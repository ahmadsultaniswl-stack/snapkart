import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class NotificationHelper {
  static Future<bool> _isEnabled(String key, bool defaultVal) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultVal;
  }

  static Future<void> showOrderNotification({
    required String title,
    required String body,
  }) async {
    final enabled = await _isEnabled('order_notifications', true);
    if (!enabled) return;

    await flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'snapkart',
          'SnapKart Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  static Future<void> showDeliveryNotification({
    required String title,
    required String body,
  }) async {
    final enabled = await _isEnabled('delivery_notifications', true);
    if (!enabled) return;

    await flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'snapkart',
          'SnapKart Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}