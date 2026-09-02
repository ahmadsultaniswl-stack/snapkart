import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var opacity = 0.0.obs;
  var scale = 0.8.obs;
  var progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimations();
  }

  void _startAnimations() async {
    opacity.value = 1.0;
    scale.value = 1.0;

    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(const Duration(milliseconds: 30));
      progress.value = i / 100;
    }

    await Future.delayed(const Duration(milliseconds: 500));

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
