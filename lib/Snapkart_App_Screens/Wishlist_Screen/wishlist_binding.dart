import 'package:get/get.dart';
import 'package:snapkart/Snapkart_App_Screens/Wishlist_Screen/wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishlistController());
  }
}
