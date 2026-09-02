import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Order_Detail/orderdetail_controller.dart';

class OrderdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderdetailController());
  }
}
