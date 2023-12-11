import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorYellow500,
      body: Center(
        child: Text(
          'Ulmo\nFind Restaurants',
          textAlign: TextAlign.center,
          style: heading1semi,
        ),
      ),
    );
  }
}
