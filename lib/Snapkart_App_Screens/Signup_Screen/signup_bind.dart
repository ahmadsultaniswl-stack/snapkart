import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Signup_Screen/signup_cont.dart';

class SignupBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}
