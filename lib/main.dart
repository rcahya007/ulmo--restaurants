import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/presentation/extensions/route_name.dart';
import 'package:ulmo_restaurants/presentation/pages/initial_page.dart';
import 'package:ulmo_restaurants/presentation/pages/splash_screen_page.dart';
import 'package:ulmo_restaurants/provider/list_of_search.dart';
import 'package:ulmo_restaurants/provider/restaurant_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
