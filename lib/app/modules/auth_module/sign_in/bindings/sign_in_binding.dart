import 'package:get/get.dart';
import 'package:fdzone_helper/app/data/repository/auth/auth_repo.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(authRepository: AuthRepo()),
    );
  }
}
