import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  var wishlistItems = <ModelClass>[].obs;

  static const String _wishlistKey = 'wishlist_items';

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_wishlistKey);

      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        final items = jsonList
            .map((json) => ModelClass.fromJson(json))
            .toList();
        wishlistItems.assignAll(items);
      }
    } catch (e) {
      debugPrint('Wishlist load error: $e');
    }
  }


  Future<void> _saveWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = wishlistItems.map((item) => item.toJson()).toList();
      await prefs.setString(_wishlistKey, jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Wishlist save error: $e');
    }
  }


  void toggleWishlist(ModelClass product) {
    final exists = wishlistItems.any((item) => item.id == product.id);

    if (exists) {
      wishlistItems.removeWhere((item) => item.id == product.id);
      _saveWishlist();
      Get.snackbar(
        'Removed from Wishlist',
        '${product.title ?? 'Product'} removed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey.shade200,
        colorText: Colors.grey.shade700,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } else {
      wishlistItems.add(product);
      _saveWishlist();
      Get.snackbar(
        '❤️ Added to Wishlist',
        '${product.title ?? 'Product'} added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.pink.shade100,
        colorText: Colors.pink.shade900,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }


  bool isWishlisted(dynamic productId) {
    return wishlistItems.any((item) => item.id == productId);
  }

  void removeFromWishlist(dynamic productId) {
    wishlistItems.removeWhere((item) => item.id == productId);
    _saveWishlist();
  }


  int get wishlistCount => wishlistItems.length;
}
