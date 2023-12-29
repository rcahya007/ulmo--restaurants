import 'package:flutter/material.dart';
import 'package:ulmo_restaurants/data/model/restaurants_response_model.dart';
import 'package:ulmo_restaurants/main.dart';
import 'package:ulmo_restaurants/utils/notification_helper.dart';

class SettingsPage extends StatefulWidget {
  static const String settingsTitle = 'Settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      context,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SettingsPage.settingsTitle),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: ButtonTheme(
            //     buttonColor: Colors.grey[300],
            //     minWidth: double.infinity,
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.black87,
            //         foregroundColor: Colors.grey[300],
            //         minimumSize: const Size(88, 36),
            //         padding: const EdgeInsets.symmetric(horizontal: 16),
            //         shape: const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(2)),
            //         ),
            //       ),
            //       onPressed: () async {
            //         await _notificationHelper
            //             .showNotification(flutterLocalNotificationsPlugin);
            //       },
            //       child: const Text('Show Notification'),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ButtonTheme(
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
                  onPressed: () async {
                    await _notificationHelper.showBigPictureNotification(
                      flutterLocalNotificationsPlugin,
                      'https://restaurant-api.dicoding.dev/images/small/14',
                      'https://restaurant-api.dicoding.dev/images/large/14',
                      Restaurant(
                        id: 'rqdv5juczeskfw1e867',
                        name: 'Melting Pot',
                        description:
                            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
                        pictureId: '14',
                        city: 'Medan',
                        rating: 4.2,
                      ),
                      
                    );
                  },
                  child: const Text('Show big picture notification [Android]'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
