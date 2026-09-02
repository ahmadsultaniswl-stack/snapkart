import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'App_Routes/routes_view.dart';
import 'Snapkart_App_Screens/Cart_Screen/cart_controller.dart';
import 'Snapkart_App_Screens/Recently_Viewed/recently_view_controller.dart';
import 'Snapkart_App_Screens/Wishlist_Screen/wishlist_controller.dart';
import 'Utilities_Screens/App_Colors/app_colors.dart';
import 'Utilities_Screens/App_Translation/app_translation.dart';
import 'Utilities_Screens/Currency_Service/currency_service.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // for currency
  CurrencyService.instance.init();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Get.put(CartController());
  Get.put(WishlistController());
  Get.put(RecentlyViewedController());

  final prefs = await SharedPreferences.getInstance();
  final String savedLangCode = prefs.getString('language_code') ?? 'en';
  final String savedCountryCode = prefs.getString('country_code') ?? 'US';
  final bool savedIsDarkMode = prefs.getBool('isDarkMode') ?? false;

  await _initNotifications();

  runApp(
    MyApp(
      initialLocale: Locale(savedLangCode, savedCountryCode),
      initialThemeMode: savedIsDarkMode ? ThemeMode.dark : ThemeMode.light,
    ),
  );
}

Future<void> _initNotifications() async {
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(alert: true, badge: true, sound: true);
  log("Permission status: ${settings.authorizationStatus}");

  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInit = DarwinInitializationSettings();
  const initSettings = InitializationSettings(
    android: androidInit,
    iOS: iosInit,
  );
  await flutterLocalNotificationsPlugin.initialize(settings: initSettings);

  const channel = AndroidNotificationChannel(
    'snapkart',
    'SnapKart Notifications',
    importance: Importance.high,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  // 3. FCM Token print karo
  String? token = await FirebaseMessaging.instance.getToken();
  log("FCM TOKEN: $token");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log("Foreground message: ${message.notification?.title}");

    final notification = message.notification;
    if (notification != null) {
      await flutterLocalNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
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
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log("Notification tapped: ${message.data}");
  });
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  final ThemeMode initialThemeMode;
  const MyApp({
    super.key,
    required this.initialLocale,
    required this.initialThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      translations: AppTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        cardColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E2E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: initialThemeMode,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
