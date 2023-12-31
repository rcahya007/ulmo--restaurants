import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/common/navigation.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/data/model/restaurant_local_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/route_name.dart';
import 'package:ulmo_restaurants/presentation/pages/detail_restaurant_page/detail_restaurant_page.dart';
import 'package:ulmo_restaurants/presentation/pages/initial_page.dart';
import 'package:ulmo_restaurants/presentation/pages/splash_screen_page.dart';
import 'package:ulmo_restaurants/provider/add_review_provider.dart';
import 'package:ulmo_restaurants/provider/db_provider.dart';
import 'package:ulmo_restaurants/provider/detail_restaurant.dart';
import 'package:ulmo_restaurants/provider/list_of_search.dart';
import 'package:ulmo_restaurants/provider/restaurant_provider.dart';
import 'package:ulmo_restaurants/utils/background_service.dart';
import 'package:ulmo_restaurants/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
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
          navigatorKey: navigatorKey,
          initialRoute: RouteName.splashScreen,
          routes: {
            RouteName.splashScreen: (context) => const MyHomePage(),
            RouteName.initialPage: (context) => ChangeNotifierProvider(
                  create: (context) =>
                      RestaurantProvider(apiRestaurant: ApiRestaurant()),
                  child: const InitialPage(),
                ),
            RouteName.detailRestaurantPage: (context) {
              final String? arg =
                  ModalRoute.of(context)?.settings.arguments as String?;
              return FutureBuilder<RestaurantLocalModel?>(
                future: arg != null
                    ? Provider.of<DbProvider>(context).getRestaurantById(arg)
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Menampilkan loading jika data sedang diambil
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Menampilkan pesan error jika terjadi kesalahan
                  } else {
                    final data = snapshot.data;
                    return ChangeNotifierProvider(
                      create: (context) => DetailRestaurantProvider(
                        apiRestaurant: ApiRestaurant(),
                        id: arg,
                      ),
                      child: ChangeNotifierProvider(
                        create: (context) =>
                            AddReviewProvider(apiRestaurant: ApiRestaurant()),
                        child: DetailRestaurantPage(
                          restaurantLocalModel: data,
                        ),
                      ),
                    );
                  }
                },
              );
            }
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
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, RouteName.initialPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
