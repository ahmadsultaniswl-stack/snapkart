import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utilities_Screens/App_Colors/app_colors.dart';
import '../../Utilities_Screens/Auth_Services/auth_services.dart';
import '../../Utilities_Screens/Cloudinary_Service/cloudinary_service.dart';
import '../Login_Screen/login_view.dart';

class SignupController extends GetxController {
  final AuthService _authService = AuthService.instance;

  // Form fields
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;

  // Error fields
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxString firstNameError = ''.obs;
  final RxString lastNameError = ''.obs;

  // UI states
  final RxBool isLoading = false.obs;
  final RxBool isRegistered = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxDouble animationValue = 0.0.obs;

  // Focus states for better UX
  final RxBool isEmailFocused = false.obs;
  final RxBool isPasswordFocused = false.obs;
  final RxBool isConfirmPasswordFocused = false.obs;
  final RxBool isFirstNameFocused = false.obs;
  final RxBool isLastNameFocused = false.obs;

  // Profile image
  final Rx<File?> profileImage = Rx<File?>(null);
  String? _tempImagePath;

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      animationValue.value = 1.0;
    });
  }

  // Image picker with better UI feedback
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);

      // Face check karein
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      bool hasFace = await _hasFace(file);

      Get.back(); // loading dialog band karein

      if (!hasFace) {
        Get.snackbar(
          'Invalid Photo',
          'Please select a photo that clearly shows a human face',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        return; // image set nahi hogi
      }

      profileImage.value = file;

      Get.snackbar(
        'Profile Photo',
        'Photo selected successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
    }
  }

  Future<bool> _hasFace(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate),
    );

    final faces = await faceDetector.processImage(inputImage);
    await faceDetector.close();

    return faces.isNotEmpty;
  }

  void clearForm() {
    email.value = '';
    password.value = '';
    confirmPassword.value = '';
    firstName.value = '';
    lastName.value = '';
    profileImage.value = null;
    clearErrors();
  }

  void clearErrors() {
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
  }

  bool validateEmail() {
    if (email.value.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email.value)) {
      emailError.value = 'Please enter a valid email address';
      return false;
    }

    emailError.value = '';
    return true;
  }

  bool validatePassword() {
    if (password.value.isEmpty) {
      passwordError.value = 'Password is required';
      return false;
    }

    if (password.value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return false;
    }

    passwordError.value = '';
    return true;
  }

  bool validateConfirmPassword() {
    if (confirmPassword.value.isEmpty) {
      confirmPasswordError.value = 'Confirm password is required';
      return false;
    }

    if (password.value != confirmPassword.value) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }

    confirmPasswordError.value = '';
    return true;
  }

  bool validateNames() {
    bool isValid = true;

    if (firstName.value.isEmpty) {
      firstNameError.value = 'First name is required';
      isValid = false;
    } else {
      firstNameError.value = '';
    }

    if (lastName.value.isEmpty) {
      lastNameError.value = 'Last name is required';
      isValid = false;
    } else {
      lastNameError.value = '';
    }

    return isValid;
  }

  bool validateForm() {
    final isEmailValid = validateEmail();
    final isPasswordValid = validatePassword();
    final isConfirmPasswordValid = validateConfirmPassword();
    final areNamesValid = validateNames();

    return isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid &&
        areNamesValid;
  }

  // Future<void> register() async {
  //   if (!validateForm()) {
  //     _showModernSnackbar(
  //       title: "Validation Error",
  //       message: "Please check all fields",
  //       isError: true,
  //     );
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   try {
  //     User? user = await _authService.registerWithEmailAndPassword(
  //       email: email.value,
  //       password: password.value,
  //       firstName: firstName.value,
  //       lastName: lastName.value,
  //     );
  //
  //     if (user != null) {
  //       // _showModernSnackbar(
  //       //   title: "Success!",
  //       //   message: "Account created successfully",
  //       //   isError: false,
  //       //   duration: 2,
  //       // );
  //
  //       clearForm();
  //       await Future.delayed(const Duration(milliseconds: 500));
  //       Get.offAll(() => LoginView());
  //     }
  //   } catch (e) {
  //     print("Registration Error: $e");
  //     _showModernSnackbar(
  //       title: "Registration Failed",
  //       message: e.toString(),
  //       isError: true,
  //       duration: 3,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> register() async {
    if (!validateForm()) {
      _showModernSnackbar(
        title: "Validation Error",
        message: "Please check all fields",
        isError: true,
      );
      return;
    }

    isLoading.value = true;

    try {
      // 1. Cloudinary par upload
      String? imageUrl;
      if (profileImage.value != null) {
        imageUrl = await CloudinaryService.uploadImage(profileImage.value!);
      }

      // 2. Firebase Auth signup (Firestore mein bhi save karne k liye auth_services update zaroori)
      User? user = await _authService.registerWithEmailAndPassword(
        email: email.value,
        password: password.value,
        firstName: firstName.value,
        lastName: lastName.value,
        imageUrl: imageUrl,
      );

      if (user != null) {
        // 3. Is user ki image ko "current login screen image" k tor par save karein
        final prefs = await SharedPreferences.getInstance();
        if (imageUrl != null) {
          await prefs.setString('login_screen_profile_image', imageUrl);
          print("DEBUG SAVED: $imageUrl"); // 👈 YE NAYI LINE ADD KARNI HAI
        } else {
          await prefs.remove('login_screen_profile_image');
        }

        clearForm();
        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAll(() => LoginView());
      }
    } catch (e) {
      print("Registration Error: $e");
      _showModernSnackbar(
        title: "Registration Failed",
        message: e.toString(),
        isError: true,
        duration: 3,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool get isFormValid {
    return email.value.isNotEmpty &&
        password.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty;
  }

  void _showModernSnackbar({
    required String title,
    required String message,
    required bool isError,
    int duration = 2,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.red.shade700 : AppColors.secondary,
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      duration: Duration(seconds: duration),
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
        size: 28,
      ),
      shouldIconPulse: false,
      barBlur: 20,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
