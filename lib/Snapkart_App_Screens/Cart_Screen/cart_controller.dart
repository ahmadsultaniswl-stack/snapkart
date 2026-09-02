import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  var cartItems = <Map<String, dynamic>>[].obs;

  // ✅ Total quantity getter
  int get cartItemCount {
    int total = 0;
    for (var item in cartItems) {
      total += (item['quantity'] as int? ?? 1);
    }
    return total;
  }

  // NAYA - is item ka current unit price (tier ke hisaab se)
  double getUnitPrice(Map<String, dynamic> item) {
    final basePrice = (item['price'] as num? ?? 0).toDouble();
    final quantity = (item['quantity'] as int? ?? 1);
    final rawTiers = item['priceTiers'] as List?;

    if (rawTiers == null || rawTiers.isEmpty) return basePrice;

    final tiers = rawTiers.map((t) => Map<String, dynamic>.from(t)).toList()
      ..sort((a, b) => (b['minQty'] as int).compareTo(a['minQty'] as int));

    for (var tier in tiers) {
      if (quantity >= (tier['minQty'] as int)) {
        return (tier['price'] as num).toDouble();
      }
    }
    return basePrice;
  }

  // NAYA - is item par kitni bachat hui
  double getItemSavings(Map<String, dynamic> item) {
    final basePrice = (item['price'] as num? ?? 0).toDouble();
    final quantity = (item['quantity'] as int? ?? 1);
    final unitPrice = getUnitPrice(item);
    return (basePrice - unitPrice) * quantity;
  }

  //  Total price getter (tier-aware ab)
  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      final quantity = (item['quantity'] as int? ?? 1);
      total +=
          getUnitPrice(item) *
          quantity; // CHANGE - flat price ki jagah tier price
    }
    return total;
  }

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart_items');
    if (cartJson != null) {
      final List decoded = jsonDecode(cartJson);
      cartItems.value = decoded
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart_items', jsonEncode(cartItems.toList()));
  }

  void addToCart(Map<String, dynamic> product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item['productId'] == product['productId'],
    );

    if (existingIndex != -1) {
      final existing = cartItems[existingIndex];
      cartItems[existingIndex] = {
        ...existing,
        'quantity':
            (existing['quantity'] as int) + (product['quantity'] as int),
      };
    } else {
      cartItems.add(product);
    }

    cartItems.refresh();
    saveCart();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    cartItems.refresh();
    saveCart();
  }

  // NAYA - quantity ka `+`/`-` button ke liye
  void updateQuantity(int index, int newQuantity) {
    if (newQuantity < 1) return;
    final existing = cartItems[index];
    cartItems[index] = {...existing, 'quantity': newQuantity};
    cartItems.refresh();
    saveCart();
  }

  void clearCart() {
    cartItems.clear();
    saveCart();
  }
}
