import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Detail_Screen/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}
