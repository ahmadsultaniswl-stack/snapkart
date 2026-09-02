import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();

  var isSaving = false.obs;
  var isEditMode = false.obs;
  String? addressId;

  // NEW: lat/lng storage
  double? latitude;
  double? longitude;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      addressId = args['addressId'];
      print('👉 EDIT MODE - addressId: $addressId');
      nameController.text = args['name'] ?? '';
      phoneController.text = args['phone'] ?? '';
      streetController.text = args['street'] ?? '';
      cityController.text = args['city'] ?? '';
      provinceController.text = args['province'] ?? '';
      // NEW: pre-fill lat/lng in edit mode
      latitude = args['latitude']?.toDouble();
      longitude = args['longitude']?.toDouble();
      isEditMode.value = true;
    }
  }

  // NEW: called after map picker returns
  void setPickedLocation(double lat, double lng, String address) {
    latitude = lat;
    longitude = lng;
    streetController.text = address;
  }

  Future<void> saveAddress() async {
    // ✅ Step 1: Check karo fields fill hain
    print('👉 saveAddress called');
    print('name: ${nameController.text}');
    print('phone: ${phoneController.text}');
    print('street: ${streetController.text}');
    print('city: ${cityController.text}');
    print('province: ${provinceController.text}');

    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        streetController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        provinceController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'fill all field',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    try {
      isSaving(true);

      final uid = _auth.currentUser?.uid;
      print('👉 UID: $uid');

      if (uid == null) {
        Get.snackbar('Error', 'User logged in nahi hai');
        return;
      }

      final data = {
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'street': streetController.text.trim(),
        'city': cityController.text.trim(),
        'province': provinceController.text.trim(),
        // NEW: save coordinates if picked
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
      };

      if (isEditMode.value && addressId != null) {
        // ✅ Update existing address
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('addresses')
            .doc(addressId)
            .update(data);

        Get.snackbar(
          'Success',
          'Address update successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );
      } else {
        // ✅ Naya address add karo
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('addresses')
            .add({...data, 'createdAt': FieldValue.serverTimestamp()});

        Get.snackbar(
          'Success',
          'Address save ho gaya!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );
      }

      Get.back();
    } catch (e) {
      print('ERROR: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        duration: const Duration(seconds: 6),
      );
    } finally {
      isSaving(false);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    provinceController.dispose();
    super.onClose();
  }
}
