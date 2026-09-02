import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  // ── Notifications ──
  var orderNotifications = true.obs;
  var promoNotifications = false.obs;
  var deliveryNotifications = true.obs;

  // ── Language ──
  var selectedLanguage = 'English'.obs;

  final RxBool isPasswordVisible = false.obs;
  var oldPassVisible = false.obs;
  var newPassVisible = false.obs;
  var confirmPassVisible = false.obs;

  var isLoading = false.obs;
  var isDeleting = false.obs;
  var isLoggingOut = false.obs;

  var selectedOption = "".obs;

  final List<String> languages = ['Urdu', 'English'];

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleOldPass() {
    oldPassVisible.value = !oldPassVisible.value;
  }

  void toggleNewPass() {
    newPassVisible.value = !newPassVisible.value;
  }

  void toggleConfirmPass() {
    confirmPassVisible.value = !confirmPassVisible.value;
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setDeleting(bool value) {
    isDeleting.value = value;
  }

  void setLoggingOut(bool value) {
    isLoggingOut.value = value;
  }

  void setSelectedOption(String option) {
    selectedOption.value = option;
  }

  // ── SharedPreferences se load karo ──
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    orderNotifications.value = prefs.getBool('order_notifications') ?? true;
    promoNotifications.value = prefs.getBool('promo_notifications') ?? false;
    deliveryNotifications.value =
        prefs.getBool('delivery_notifications') ?? true;
    selectedLanguage.value = prefs.getString('language') ?? 'English';
  }

  // ── Settings save karo ──
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('order_notifications', orderNotifications.value);
    await prefs.setBool('promo_notifications', promoNotifications.value);
    await prefs.setBool('delivery_notifications', deliveryNotifications.value);
    await prefs.setString('language', selectedLanguage.value);
  }

  // ── Toggle Functions ──
  void toggleOrderNotifications(bool val) {
    orderNotifications.value = val;
    _saveSettings();
  }

  void togglePromoNotifications(bool val) {
    promoNotifications.value = val;
    _saveSettings();
  }

  void toggleDeliveryNotifications(bool val) {
    deliveryNotifications.value = val;
    _saveSettings();
  }

  // ── Language Change (Actual App Language) ──
  void changeLanguage(String lang) async {
    selectedLanguage.value = lang;

    final prefs = await SharedPreferences.getInstance();

    if (lang == 'English') {
      await prefs.setString('language_code', 'en');
      await prefs.setString('country_code', 'US');
      Get.updateLocale(const Locale('en', 'US'));
    } else if (lang == 'Urdu') {
      await prefs.setString('language_code', 'ur');
      await prefs.setString('country_code', 'PK');
      Get.updateLocale(const Locale('ur', 'PK'));
    }

    await prefs.setString('language', lang);

    Get.snackbar(
      'language'.tr,
      lang == 'English'
          ? 'Language changed to English'
          : 'زبان تبدیل کر دی گئی',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ── Logout ──
  void logout() {
    Get.defaultDialog(
      title: 'logout'.tr,
      middleText: 'do you want to logout?',
      textConfirm: 'yes',
      textCancel: 'no',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF6C63FF),
      onConfirm: () async {
        Get.back();
        Get.offAllNamed('/login');
      },
    );
  }

  // ── Clear Cache ──
  void clearCache() {
    Get.defaultDialog(
      title: 'Cache Clear',
      middleText: 'do you want to clear cached?',
      textConfirm: 'yes',
      textCancel: 'no',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF6C63FF),
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('cart_items');
        Get.back();
        Get.snackbar(
          'Cache',
          'Cache cleared',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
