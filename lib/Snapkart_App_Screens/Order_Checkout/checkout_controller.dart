import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../Utilities_Screens/Notification_Helper/notification_helper.dart';
import '../Cart_Screen/cart_controller.dart';

class CheckoutController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Address ---
  var savedAddresses = <Map<String, dynamic>>[].obs;
  var selectedAddressIndex = 0.obs;
  var isLoadingAddresses = true.obs;

  // --- Payment ---
  var selectedPayment = 'Cash on Delivery'.obs;
  final List<Map<String, dynamic>> paymentMethods = [
    {'name': 'Cash on Delivery', 'icon': '💵'},
    {'name': 'Credit/Debit Card', 'icon': '💳'},
    {'name': 'JazzCash / EasyPaisa', 'icon': '📱'},
    {'name': 'Bank Transfer', 'icon': '🏦'},
  ];

  // --- Order ---
  var isPlacingOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    try {
      isLoadingAddresses(true);
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('addresses')
          .get();

      savedAddresses.value = snapshot.docs.map((doc) {
        final data = doc.data();
        data['addressId'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Addresses not load: $e');
    } finally {
      isLoadingAddresses(false);
    }
  }

  void selectAddress(int index) {
    selectedAddressIndex.value = index;
  }

  void selectPayment(String method) {
    selectedPayment.value = method;
  }

  List<Map<String, dynamic>> _buildOrderItems(
    List<Map<String, dynamic>> cartItems,
  ) {
    final cartController = CartController.instance;
    return cartItems.map((item) {
      final quantity = (item['quantity'] as int? ?? 1);
      final unitPrice = cartController.getUnitPrice(item); // tier price
      final basePrice = (item['price'] as num? ?? 0).toDouble();
      return {
        ...item,
        'unitPrice': unitPrice, // jo actually charge hui
        'basePrice': basePrice, // original price (record ke liye)
        'itemTotal': unitPrice * quantity,
      };
    }).toList();
  }

  // NAYA - total bhi khud calculate karo, caller ke total par depend mat karo
  double _calculateTotal(List<Map<String, dynamic>> orderItems) {
    return orderItems.fold(
      0.0,
      (sum, item) => sum + (item['itemTotal'] as num).toDouble(),
    );
  }

  Future<void> placeOrder(
    List<Map<String, dynamic>> cartItems,
    double total,
  ) async {
    await fetchAddresses();
    if (savedAddresses.isEmpty) {
      Get.snackbar('Address', 'add address first');
      return;
    }

    try {
      isPlacingOrder(true);
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final selectedAddr = savedAddresses[selectedAddressIndex.value];

      // NAYA - tier-aware items aur sahi total
      final orderItems = _buildOrderItems(cartItems);
      final correctTotal = _calculateTotal(orderItems);

      //  docRef se order ID milega
      final docRef = await _firestore.collection('orders').add({
        'userId': uid,
        'items': orderItems, // CHANGE - discounted unitPrice/itemTotal ke saath
        'totalAmount': correctTotal, // CHANGE - khud calculate kiya hua total
        'address': selectedAddr,
        'paymentMethod': selectedPayment.value,
        'status': 'Pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      //  Cart clear karo
      CartController.instance.clearCart();

      //  Order placed notification bhejo
      await NotificationHelper.showOrderNotification(
        title: 'Order Placed ',
        body:
            'Your order #${docRef.id.substring(0, 6)} has been placed successfully!',
      );

      //  Date format karo
      final now = DateTime.now();
      final formattedDate = '${now.day}/${now.month}/${now.year}';

      //  Order success screen par jao arguments ke sath
      Get.offAllNamed(
        '/ordercheck',
        arguments: {
          'orderId': docRef.id,
          'orderDate': formattedDate,
          'paymentMethod': selectedPayment.value,
          'totalAmount': correctTotal, // CHANGE
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Order not placed: $e');
    } finally {
      isPlacingOrder(false);
    }
  }
}
