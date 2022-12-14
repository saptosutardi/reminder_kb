import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int day) async {
    print("input day = $day");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      // ignore: prefer_const_constructors

      tz.TZDateTime.now(tz.local).add(Duration(
          days: day)), //schedule the notification to show after our time.
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel_1',
          'main Channel_1',
          channelDescription: "reminderKB_1",
          importance: Importance.max,
          priority: Priority.max,
          // playSound: true,
          // sound: UriAndroidNotificationSound(
          //     "assets/tunes/waktukb.mp3"), //D:\Kerja\Project\flutter_reminder_kb\assets\tunes\waktukb.mp3
        ),
      ),

      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:
          true, // To show notification even when the app is closed
    );
  }
}
