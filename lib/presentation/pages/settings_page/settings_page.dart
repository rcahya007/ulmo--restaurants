import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ButtonTheme(
              buttonColor: Colors.grey[300],
              minWidth: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.grey[300],
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                onPressed: () {},
                child: const Text('Show Notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
