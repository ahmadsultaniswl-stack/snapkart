import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutController extends GetxController {
  var appName = "Snapkart App".obs;

  var developer = "Ahmad Sultan".obs;
  var version = "1.0.0".obs;
  var email = "ahmadsultaniswl@gmail.com".obs;

  // Complaint box
  final TextEditingController complaintController = TextEditingController();
  var isSubmitting = false.obs;

  Future<void> submitComplaint() async {
    final text = complaintController.text.trim();

    if (text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please write your complaint before submitting',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('complaints').add({
        'message': text,
        'userId': user?.uid ?? 'guest',
        'userEmail': user?.email ?? 'not_logged_in',
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      complaintController.clear();

      Get.snackbar(
        'Success',
        'Your complaint has been submitted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not submit complaint: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email.value,
      queryParameters: {'subject': 'Support Request', 'body': 'HelloTeam,'},
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not launch email client',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> openFacebook() async {
    final Uri facebookUri = Uri.parse(
      'https://www.facebook.com/saieahmadsultan',
    );
    await launchUrl(facebookUri, mode: LaunchMode.externalApplication);
  }

  Future<void> openLinkedIn() async {
    final Uri linkedInUri = Uri.parse(
      'https://www.linkedin.com/in/saieahmadsultan',
    );
    await launchUrl(linkedInUri, mode: LaunchMode.externalApplication);
  }

  @override
  void onClose() {
    complaintController.dispose();
    super.onClose();
  }
}
