import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utilities_Screens/App_Model/app_model.dart';

class RecentlyViewedController extends GetxController {
  static RecentlyViewedController get instance => Get.find();

  var recentItems = <Map<String, dynamic>>[].obs;

  static const int maxItems = 10;

  @override
  void onInit() {
    super.onInit();
    loadRecent();
  }

  Future<void> loadRecent() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('recently_viewed');
    if (data != null) {
      final List decoded = jsonDecode(data);
      recentItems.value = decoded
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
  }

  Future<void> saveRecent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recently_viewed', jsonEncode(recentItems.toList()));
  }

  void addProduct(ModelClass product) {
    if (product.id == null) return;

    recentItems.removeWhere((item) => item['id'] == product.id);

    recentItems.insert(0, {
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'image': product.image,
    });

    if (recentItems.length > maxItems) {
      recentItems.removeRange(maxItems, recentItems.length);
    }

    recentItems.refresh();
    saveRecent();
  }

  void clearRecent() {
    recentItems.clear();
    saveRecent();
  }
}
