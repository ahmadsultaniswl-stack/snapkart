import 'dart:ui';

import 'package:get/get.dart';

class OrderdetailController extends GetxController {
  var orderId = ''.obs;
  var orderDate = ''.obs;
  var paymentMethod = ''.obs;
  var totalAmount = 0.0.obs;
  var status = ''.obs;
  var items = <dynamic>[].obs;
  //var address = <String, dynamic>{}.obs;
  var address = Rx<Map<String, dynamic>>({});

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      orderId.value = args['orderId'] ?? '';
      paymentMethod.value = args['paymentMethod'] ?? '';
      totalAmount.value = (args['totalAmount'] ?? 0.0).toDouble();
      status.value = args['status'] ?? 'Pending';
      items.value = args['items'] ?? [];
      address.value = Map<String, dynamic>.from(args['address'] ?? {});

      // Date format
      if (args['createdAt'] != null) {
        try {
          final date = args['createdAt'].toDate();
          orderDate.value = '${date.day}/${date.month}/${date.year}';
        } catch (_) {
          orderDate.value = 'N/A';
        }
      }
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

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFF9800);
      case 'confirmed':
        return const Color(0xFF2196F3);
      case 'shipped':
        return const Color(0xFF3F51B5);
      case 'delivered':
        return const Color(0xFF4CAF50);
      case 'cancelled':
        return const Color(0xFFF44336);
      default:
        return const Color(0xFFFF9800);
    }
  }
}
