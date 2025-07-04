// lib/notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        print('Notification tapped with payload: ${response.payload}');
      },
    );

    // ✅ Create channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'cradle_channel_id',
      'Cradle Alerts',
      description: 'Alerts for cradle sensors',
      importance: Importance.max,
    );

    final androidPlugin = _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(channel);
    }

    // ✅ Request notification permission (Android 13+)
    if (await Permission.notification.isDenied ||
        await Permission.notification.isPermanentlyDenied) {
      final status = await Permission.notification.request();
      print('🔔 Notification permission status: $status');
    }
  }


  //
  // static Future<void> init() async {
  //   const AndroidInitializationSettings androidInit =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //
  //   const InitializationSettings initSettings = InitializationSettings(
  //     android: androidInit,
  //   );
  //
  //   // ✅ Initialize the plugin
  //   await _notificationsPlugin.initialize(
  //     initSettings,
  //     onDidReceiveNotificationResponse: (response) {
  //       print('Notification tapped with payload: ${response.payload}');
  //     },
  //   );
  //
  //   // ✅ Create the notification channel (Android 8+)
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'cradle_channel_id', // must match the one used in showNotification
  //     'Cradle Alerts',
  //     description: 'Alerts for cradle sensors',
  //     importance: Importance.max,
  //   );
  //
  //   // ✅ Register the channel with the Android system
  //   final androidPlugin = _notificationsPlugin.resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>();
  //
  //   if (androidPlugin != null) {
  //     await androidPlugin.createNotificationChannel(channel);
  //     print('✅ Notification channel created');
  //   }
  // }



  // static Future<void> init() async {
  //
  //   const AndroidInitializationSettings androidInit =
  //   AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const InitializationSettings initSettings = InitializationSettings(
  //     android: androidInit,
  //   );
  //
  //
  //   await _notificationsPlugin.initialize(
  //     initSettings,
  //     onDidReceiveNotificationResponse: (response) {
  //
  //       print('Notification tapped with payload: ${response.payload}');
  //     },
  //   );
  // }


  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'cradle_channel_id',
      'Cradle Alerts',
      channelDescription: 'Alerts for cradle sensors',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }
}
