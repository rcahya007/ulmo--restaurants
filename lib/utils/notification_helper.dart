import 'dart:convert';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:ulmo_restaurants/common/navigation.dart';
import 'package:ulmo_restaurants/data/model/restaurants_response_model.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  // Kita akan membuat beberapa fungsi jenis notifikasi di dalam kelas ini
  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('icon_apps');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showBigPictureNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String smallPict,
      String bigPict,
      Restaurant restaurants) async {
    var channelId = "01";
    var channelName = "channel_01";
    var channelDesc = "dicoding channel";

    var smallIconPath = await _downloadAndSaveFile(smallPict, 'smallPict');
    var bigPicturePath = await _downloadAndSaveFile(bigPict, 'bigPict');

    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(smallIconPath),
      contentTitle: restaurants.name,
      htmlFormatContentTitle: true,
      summaryText:
          'Located in ${restaurants.city} with a rating ${restaurants.rating}',
      htmlFormatSummaryText: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Ulmo Restaurant',
      restaurants.name,
      platformChannelSpecifics,
      payload: json.encode(restaurants),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = Restaurant.fromJson(json.decode(payload));
      Navigation.intentWithData(route, data);
    });
  }
}
