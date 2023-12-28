import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/presentation/extensions/route_name.dart';
import 'package:ulmo_restaurants/presentation/pages/initial_page.dart';
import 'package:ulmo_restaurants/presentation/pages/splash_screen_page.dart';
import 'package:ulmo_restaurants/provider/db_provider.dart';
import 'package:ulmo_restaurants/provider/list_of_search.dart';
import 'package:ulmo_restaurants/provider/restaurant_provider.dart';
import 'package:ulmo_restaurants/provider/scheduling_provider.dart';
import 'package:ulmo_restaurants/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
  // final NotificationHelper notificationHelper = NotificationHelper();
  // await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  // notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DbProvider(),
      child: ChangeNotifierProvider(
        create: (context) => ListOfSearchProvider(),
        child: MaterialApp(
          initialRoute: RouteName.splashScreen,
          routes: {
            RouteName.splashScreen: (context) => const MyHomePage(),
            RouteName.initialPage: (context) => ChangeNotifierProvider(
                create: (context) =>
                    RestaurantProvider(apiRestaurant: ApiRestaurant()),
                child: const InitialPage()),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    super.initState();
    // _notificationHelper.configureSelectNotificationSubject(
    //   context,
    // );
    // _notificationHelper.configureDidReceiveLocalNotificationSubject(
    //     context, DetailPage.routeName);
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, RouteName.initialPage),
    );
  }

  // @override
  // void dispose() {
  //   selectNotificationSubject.close();
  //   didReceiveLocalNotificationSubject.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
