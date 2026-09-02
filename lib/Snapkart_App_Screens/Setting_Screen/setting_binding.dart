import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Setting_Screen/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
