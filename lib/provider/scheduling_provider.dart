import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulmo_restaurants/utils/background_service.dart';
import 'package:ulmo_restaurants/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  Future<bool> scheduledNews(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSchedulingRestaurant', value);
    if (value) {
      prefs.setBool('isSchedulingRestaurant', value);
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      prefs.setBool('isSchedulingRestaurant', value);
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
