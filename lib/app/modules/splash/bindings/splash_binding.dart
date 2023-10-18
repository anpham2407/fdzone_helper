import 'package:get/get.dart';
import 'package:fdzone_helper/app/data/repository/auth/auth_repo.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(authRepo: AuthRepo()));
  }
}
