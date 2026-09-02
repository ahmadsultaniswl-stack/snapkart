import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Cart_Screen/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
