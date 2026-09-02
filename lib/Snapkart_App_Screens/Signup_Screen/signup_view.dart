import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Signup_Screen/signup_cont.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Auth_Services/auth_services.dart';
import '../Login_Screen/login_view.dart';

class SignupView extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  final AuthService con = Get.put(AuthService());
  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: _buildModernAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(
              () => AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: controller.animationValue.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildWelcomeText(),

                    Center(
                      child: Obx(
                        () => GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white.withOpacity(0.08),
                                backgroundImage:
                                    controller.profileImage.value != null
                                    ? FileImage(controller.profileImage.value!)
                                    : null,
                                child: controller.profileImage.value == null
                                    ? Icon(
                                        Icons.person_outline,
                                        size: 50,
                                        color: Colors.grey.shade500,
                                      )
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const SizedBox(height: 30),

                    _buildModernTextField(
                      label: 'first_name'.tr,
                      hintText: 'Enter your first name',
                      errorText: controller.firstNameError.value,
                      onChanged: (value) => controller.firstName.value = value,
                      prefixIcon: Icons.person_2_outlined,
                      isFocused: controller.isFirstNameFocused,
                    ),

                    const SizedBox(height: 18),

                    _buildModernTextField(
                      label: 'last_name'.tr,
                      hintText: 'Enter your last name',
                      errorText: controller.lastNameError.value,
                      onChanged: (value) => controller.lastName.value = value,
                      prefixIcon: Icons.person_outline,
                      isFocused: controller.isLastNameFocused,
                    ),

                    const SizedBox(height: 18),

                    _buildModernTextField(
                      label: 'email_address'.tr,
                      hintText: 'Enter your email',
                      errorText: controller.emailError.value,
                      onChanged: (value) => controller.email.value = value,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      isFocused: controller.isEmailFocused,
                    ),

                    const SizedBox(height: 18),

                    _buildModernPasswordField(
                      label: 'password'.tr,
                      hintText: 'Enter your password',
                      errorText: controller.passwordError.value,
                      onChanged: (value) => controller.password.value = value,
                      isVisible: controller.isPasswordVisible,
                      onToggle: controller.togglePasswordVisibility,
                      isFocused: controller.isPasswordFocused,
                    ),

                    const SizedBox(height: 18),

                    _buildModernPasswordField(
                      label: 'confirm_password'.tr,
                      hintText: 'Confirm your password',
                      errorText: controller.confirmPasswordError.value,
                      onChanged: (value) =>
                          controller.confirmPassword.value = value,
                      isVisible: controller.isConfirmPasswordVisible,
                      onToggle: controller.toggleConfirmPasswordVisibility,
                      isFocused: controller.isConfirmPasswordFocused,
                    ),

                    const SizedBox(height: 28),

                    _buildModernRegisterButton(),

                    const SizedBox(height: 16),

                    _buildLoginLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      title: Text(
        'create_account'.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'join_us_today'.tr,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'join_us_sub'.tr,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade400,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildModernTextField({
    required String label,
    required String hintText,
    required String errorText,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    IconData? prefixIcon,
    required RxBool isFocused,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey.shade300,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: errorText.isNotEmpty
                  ? Colors.red.shade400
                  : Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: TextField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            cursorColor: AppColors.secondary,
            onTap: () {
              if (label == 'first_name'.tr)
                controller.firstNameError.value = '';
              if (label == 'last_name'.tr) controller.lastNameError.value = '';
              if (label == 'email_address'.tr) controller.emailError.value = '';
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade600),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.secondary, size: 22)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Row(
              children: [
                Icon(Icons.error_outline, size: 14, color: Colors.red.shade400),
                const SizedBox(width: 6),
                Text(
                  errorText,
                  style: TextStyle(fontSize: 12, color: Colors.red.shade400),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildModernPasswordField({
    required String label,
    required String hintText,
    required String errorText,
    required Function(String) onChanged,
    required RxBool isVisible,
    required VoidCallback onToggle,
    required RxBool isFocused,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey.shade300,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: errorText.isNotEmpty
                  ? Colors.red.shade400
                  : Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: Obx(
            () => TextField(
              onChanged: onChanged,
              obscureText: !isVisible.value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              cursorColor: AppColors.secondary,
              onTap: () {
                if (label == 'password'.tr) {
                  controller.passwordError.value = '';
                } else {
                  controller.confirmPasswordError.value = '';
                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.secondary,
                  size: 22,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible.value ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  onPressed: onToggle,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.secondary,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Row(
              children: [
                Icon(Icons.error_outline, size: 14, color: Colors.red.shade400),
                const SizedBox(width: 6),
                Text(
                  errorText,
                  style: TextStyle(fontSize: 12, color: Colors.red.shade400),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildModernRegisterButton() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.secondary, AppColors.secondary.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : () => controller.register(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'create_account'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'already_have_account'.tr,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        ),
        TextButton(
          onPressed: () {
            Get.offAll(() => LoginView());
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'login'.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
