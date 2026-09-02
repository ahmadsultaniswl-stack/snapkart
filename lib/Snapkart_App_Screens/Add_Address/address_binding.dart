import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Add_Address/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAddressController());
  }
}
