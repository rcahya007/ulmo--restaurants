import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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

  // Future<void> showBigPictureNotification(
  //     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  //     String smallPict,
  //     String bigPict,
  //     Restaurant dataRestaurant) async {
  //   var smallIconPath = await _downloadAndSaveFile(smallPict, 'smallPict');
  //   var bigPicturePath = await _downloadAndSaveFile(bigPict, 'bigPict');

  //   var bigPictureStyleInformation = BigPictureStyleInformation(
  //     FilePathAndroidBitmap(bigPicturePath),
  //     largeIcon: FilePathAndroidBitmap(smallIconPath),
  //     contentTitle: dataRestaurant.name,
  //     htmlFormatContentTitle: true,
  //     summaryText:
  //         'Located in ${dataRestaurant.city} with a rating ${dataRestaurant.rating}',
  //     htmlFormatSummaryText: true,
  //   );

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       _channelId, _channelName,
  //       channelDescription: _channelDesc,
  //       styleInformation: bigPictureStyleInformation,
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker');

  //   var platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.show(
  //     int.parse(dataRestaurant.pictureId),
  //     'Ulmo Restaurant',
  //     dataRestaurant.name,
  //     platformChannelSpecifics,
  //     payload: json.encode(dataRestaurant.toJson()),
  //   );
  // }

  Future<void> showBigPictureNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      String smallPict,
      String bigPict,
      ListRestaurantResponseModel restaurants) async {
          var channelId = "01";
  var channelName = "channel_01";
  var channelDesc = "dicoding channel";

    var smallIconPath = await _downloadAndSaveFile(smallPict, 'smallPict');
    var bigPicturePath = await _downloadAndSaveFile(bigPict, 'bigPict');

    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(smallIconPath),
      contentTitle: restaurants.restaurants[0].name,
      htmlFormatContentTitle: true,
      summaryText:
          'Located in ${restaurants.restaurants[0].city} with a rating ${restaurants.restaurants[0].rating}',
      htmlFormatSummaryText: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDesc,
        styleInformation: bigPictureStyleInformation,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Ulmo Restaurant',
      restaurants.restaurants[0].name,
      platformChannelSpecifics,
      payload: json.encode(restaurants.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = ListRestaurantResponseModel.fromJson(json.decode(payload));
      var restaurant = data.restaurants[0];
      Navigation.intentWithData(route, restaurant);
      // await Navigator.pushNamed(
      //   context,
      //   route,
      //   arguments: payload,
      // );
    });
  }
}
