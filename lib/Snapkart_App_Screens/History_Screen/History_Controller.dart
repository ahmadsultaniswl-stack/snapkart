import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var orders = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: uid)
          .get();

      orders.value = snapshot.docs.map((doc) {
        final data = doc.data();
        data['orderId'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Orders load nahi ho sake: $e');
    } finally {
      isLoading(false);
    }
  }

  String getStatusEmoji(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return '🟡';
      case 'confirmed':
        return '🔵';
      case 'shipped':
        return '🚚';
      case 'delivered':
        return '🟢';
      case 'cancelled':
        return '🔴';
      default:
        return '🟡';
    }
  }

  //  Pura data pass karo
  void goToOrderDetail(Map<String, dynamic> order) {
    Get.toNamed(
      '/orderdetail',
      arguments: {
        'orderId': order['orderId'] ?? '',
        'status': order['status'] ?? 'Pending',
        'totalAmount': order['totalAmount'] ?? 0.0,
        'paymentMethod': order['paymentMethod'] ?? '',
        'items': order['items'] ?? [],
        'address': order['address'] ?? {},
        'createdAt': order['createdAt'],
      },
    );
  }

  // Ek order delete karo
  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
      orders.removeWhere((order) => order['orderId'] == orderId);
      Get.snackbar('Success', 'Order delete ho gaya');
    } catch (e) {
      Get.snackbar('Error', 'Order delete nahi ho saka: $e');
    }
  }

  // Saare orders clear karo (permanently)
  Future<void> clearAllHistory() async {
    try {
      isLoading(true);
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: uid)
          .get();

      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      orders.clear();
      Get.snackbar('Success', 'all history clear');
    } catch (e) {
      Get.snackbar('Error', 'History not clear: $e');
    } finally {
      isLoading(false);
    }
  }
}
