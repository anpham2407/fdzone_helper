import 'package:get/get.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/auth_module/sign_in/bindings/sign_in_binding.dart';
import '../modules/auth_module/sign_in/views/sign_in_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/module_1/bindings/screen1_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
      // children: [
      //   GetPage(
      //     name: _Paths.RESET_PASSWORD,
      //     page: () => const ResetPasswordView(),
      //     transition: Transition.noTransition,
      //     binding: ResetPasswordBinding(),
      //     fullscreenDialog: true,
      //   ),
      // ],
    ),
    GetPage(
        name: _Paths.DASHBOARD,
        page: () => const DashboardView(),
        bindings: [
          DashboardBinding(),
          Screen1Binding(),
        ],
        // children: [
        //   GetPage(
        //     name: _Paths.SCREEN1,
        //     page: () => const Screen1TabBarView(),
        //     binding: Screen1Binding(),
        //   ),
        // ]
      ),
  ];
}
