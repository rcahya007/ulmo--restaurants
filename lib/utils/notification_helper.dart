import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:ulmo_restaurants/data/model/restaurant_local_model.dart';
import 'package:ulmo_restaurants/data/model/restaurants_response_model.dart';
import 'package:ulmo_restaurants/presentation/pages/detail_restaurant_page/detail_restaurant_page.dart';
import 'package:ulmo_restaurants/provider/add_review_provider.dart';
import 'package:ulmo_restaurants/provider/db_provider.dart';
import 'package:ulmo_restaurants/provider/detail_restaurant.dart';

final selectNotificationSubject = BehaviorSubject<Restaurant?>();
final didReceiveLocalNotificationSubject = BehaviorSubject<Restaurant>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding channel";
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

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
      Restaurant dataRestaurant) async {
    var smallIconPath = await _downloadAndSaveFile(smallPict, 'smallPict');
    var bigPicturePath = await _downloadAndSaveFile(bigPict, 'bigPict');

    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(smallIconPath),
      contentTitle: dataRestaurant.name,
      htmlFormatContentTitle: true,
      summaryText:
          'Located in ${dataRestaurant.city} with a rating ${dataRestaurant.rating}',
      htmlFormatSummaryText: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      styleInformation: bigPictureStyleInformation,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Ulmo Restaurant',
      dataRestaurant.name,
      platformChannelSpecifics,
      payload: dataRestaurant.id,
    );
  }

  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((Restaurant? payload) async {
      final restaurantLocal = Provider.of<DbProvider>(context, listen: false)
          .getRestaurantById(payload!.id);
      RestaurantLocalModel? data;
      restaurantLocal.then((value) => data = value);
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => DetailRestaurantProvider(
                apiRestaurant: ApiRestaurant(),
                id: payload.id,
              ),
              child: ChangeNotifierProvider(
                create: (context) =>
                    AddReviewProvider(apiRestaurant: ApiRestaurant()),
                child: DetailRestaurantPage(
                  restaurantLocalModel: data,
                ),
              ),
            ),
          ));
    });
  }
}
