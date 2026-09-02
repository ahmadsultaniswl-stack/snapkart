import 'package:get/get.dart';

class OrderController extends GetxController {
  var orderId = ''.obs;
  var orderDate = ''.obs;
  var paymentMethod = ''.obs;
  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // CheckoutController se data receive karo
    final args = Get.arguments;
    if (args != null) {
      orderId.value = args['orderId'] ?? '';
      orderDate.value = args['orderDate'] ?? '';
      paymentMethod.value = args['paymentMethod'] ?? '';
      totalAmount.value = (args['totalAmount'] ?? 0.0).toDouble();
    }
  }

  void goHome() {
    Get.offAllNamed('/home');
  }
}
