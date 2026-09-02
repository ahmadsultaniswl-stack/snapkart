import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../App_Routes/routes_view.dart';
import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Auth_Services/auth_services.dart';
import '../../Utilities_Screens/Theme_Controller/theme_controller.dart';
import 'setting_controller.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final SettingController controller = Get.put(SettingController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        title: Text(
          'settings'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(context),
          ),
        ),
        backgroundColor: AppColors.cardBackground(context),
        foregroundColor: AppColors.textPrimary(context),
        elevation: 0.5,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Notifications ──
              _sectionTitle('🔔 ${'notifications'.tr}', context),
              _settingCard(
                context: context,
                children: [
                  _switchTile(
                    context: context,
                    icon: Icons.shopping_bag_outlined,
                    title: 'order_updates'.tr,
                    subtitle: 'order_updates_sub'.tr,
                    value: controller.orderNotifications.value,
                    onChanged: controller.toggleOrderNotifications,
                  ),
                  _divider(),
                  // _switchTile(
                  //   context: context,
                  //   icon: Icons.local_offer_outlined,
                  //   title: 'promotions'.tr,
                  //   subtitle: 'promotions_sub'.tr,
                  //   value: controller.promoNotifications.value,
                  //   onChanged: controller.togglePromoNotifications,
                  // ),
                  _divider(),
                  _switchTile(
                    context: context,
                    icon: Icons.delivery_dining_outlined,
                    title: 'delivery_updates'.tr,
                    subtitle: 'delivery_updates_sub'.tr,
                    value: controller.deliveryNotifications.value,
                    onChanged: controller.toggleDeliveryNotifications,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Theme ──
              _sectionTitle('appearance'.tr, context),

              _settingCard(
                context: context,
                children: [
                  _switchTile(
                    context: context,
                    icon: Icons.dark_mode_outlined,
                    title: 'dark_mode'.tr,
                    subtitle: 'dark_mode_sub'.tr,
                    value: themeController.isDarkMode.value,
                    onChanged: (val) => themeController.toggleTheme(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _sectionTitle('🌐 ${'language'.tr}', context),
              _settingCard(
                context: context,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.language,
                            color: Color(0xFF6C63FF),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'language'.tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary(context),
                            ),
                          ),
                        ),
                        DropdownButton<String>(
                          value: controller.selectedLanguage.value,
                          underline: const SizedBox(),
                          dropdownColor: AppColors.cardBackground(context),
                          style: const TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          items: controller.languages
                              .map(
                                (lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Text(lang),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            if (val != null) controller.changeLanguage(val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Account ──
              _sectionTitle('👤 ${'account'.tr}', context),
              _settingCard(
                context: context,
                children: [
                  _actionTile(
                    context: context,
                    icon: Icons.person_outline,
                    title: 'edit_profile'.tr,
                    onTap: () => Get.toNamed('/profilefetch'),
                  ),
                  _divider(),
                  _actionTile(
                    context: context,
                    icon: Icons.lock_outline,
                    title: 'change_password'.tr,
                    onTap: () => _showChangePasswordDialog(context),
                  ),

                  _divider(),
                  _actionTile(
                    context: context,
                    icon: Icons.lock_outline,
                    title: 'delete_account'.tr,
                    onTap: () => _showDeleteAccountDialog(),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Other ──
              _sectionTitle('⚙️ ${'other'.tr}', context),
              _settingCard(
                context: context,
                children: [
                  _actionTile(
                    context: context,
                    icon: Icons.logout,
                    title: 'logout'.tr,
                    titleColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: () => _logout(),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // ── Version ──
              Center(
                child: Text(
                  'SnapKart v1.0.0',
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ── Section Title ──
  Widget _sectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary(context),
        ),
      ),
    );
  }

  // ── Setting Card ──
  Widget _settingCard({
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // ── Switch Tile ──
  Widget _switchTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF6C63FF), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary(context),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6C63FF),
          ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? const Color(0xFF6C63FF)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color(0xFF6C63FF),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: titleColor ?? AppColors.textPrimary(context),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppColors.textSecondary(context),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldPassController = TextEditingController();
    final newPassController = TextEditingController();
    final confirmPassController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'change_password'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _buildPasswordField(
                  controller: oldPassController,
                  hint: 'current_password'.tr,
                  visible: controller.oldPassVisible,
                  onToggle: controller.toggleOldPass,
                ),
                const SizedBox(height: 12),

                _buildPasswordField(
                  controller: newPassController,
                  hint: 'new_password'.tr,
                  visible: controller.newPassVisible,
                  onToggle: controller.toggleNewPass,
                ),
                const SizedBox(height: 12),

                _buildPasswordField(
                  controller: confirmPassController,
                  hint: 'confirm_password'.tr,
                  visible: controller.confirmPassVisible,
                  onToggle: controller.toggleConfirmPass,
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'cancel'.tr,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          String oldPass = oldPassController.text.trim();
                          String newPass = newPassController.text.trim();
                          String confirmPass = confirmPassController.text
                              .trim();

                          if (oldPass.isEmpty ||
                              newPass.isEmpty ||
                              confirmPass.isEmpty) {
                            Get.snackbar(
                              'error'.tr,
                              "All fields required",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          if (newPass != confirmPass) {
                            Get.snackbar(
                              'error'.tr,
                              "Passwords do not match",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          try {
                            await AuthService().changePassword(
                              oldPass,
                              newPass,
                            );
                            Get.back();
                            Get.snackbar(
                              'success'.tr,
                              "Password changed successfully",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                            Get.toNamed(AppRoutes.login);
                          } catch (e) {
                            Get.snackbar(
                              'error'.tr,
                              e.toString(),
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'change'.tr,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required RxBool visible,
    required VoidCallback onToggle,
  }) {
    return Obx(
      () => TextField(
        controller: controller,
        obscureText: !visible.value,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.white.withOpacity(0.7),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              visible.value ? Icons.visibility : Icons.visibility_off,
              color: Colors.white.withOpacity(0.7),
            ),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final passwordFieldController = TextEditingController();
    final RxBool isPasswordVisible = false.obs;

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(28)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.redAccent,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'delete_account'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'delete_account_warning'.tr,
                style: TextStyle(color: Colors.white.withOpacity(0.6)),
              ),
              const SizedBox(height: 24),
              Obx(
                () => TextField(
                  controller: passwordFieldController,
                  obscureText: !isPasswordVisible.value,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'enter_password_confirm'.tr,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      icon: Icon(
                        isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white.withOpacity(0.3)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text('cancel'.tr),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        String password = passwordFieldController.text.trim();
                        if (password.isEmpty) {
                          Get.snackbar(
                            'error'.tr,
                            "Please enter password",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        try {
                          await AuthService().deleteAccount(password);
                          Get.back();
                          Get.snackbar(
                            'success'.tr,
                            "Account deleted successfully",
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                          Get.toNamed(AppRoutes.signup);
                        } catch (e) {
                          Get.snackbar(
                            'error'.tr,
                            e.toString(),
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text('delete'.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout() async {
    Get.back();
    await AuthService().signOut();
    Get.snackbar(
      'success'.tr,
      "Logged out successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.toNamed(AppRoutes.login);
  }

  // ── Divider ──
  Widget _divider() {
    return const Divider(height: 1, indent: 56, endIndent: 16);
  }
}
