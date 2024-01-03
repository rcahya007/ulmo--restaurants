import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulmo_restaurants/provider/scheduling_provider.dart';

class SettingsPage extends StatefulWidget {
  static const String settingsTitle = 'Settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool schedule = false;
  void _loadSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      schedule = prefs.getBool('isScheduleRestaurant') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SettingsPage.settingsTitle),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<SchedulingProvider>(
          create: (context) => SchedulingProvider(),
          child: ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Scheduling Restaurant'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: schedule,
                        onChanged: (value) async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isScheduleRestaurant', value);
                          setState(() {
                            schedule = value;
                            scheduled.scheduledNews(value);
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
