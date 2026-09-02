import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/History_Screen/History_Controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());
  }
}
