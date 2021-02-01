import 'package:get/get.dart';
import 'package:tarefas/app/bindings/home_binding.dart';
import 'package:tarefas/app/bindings/login_binding.dart';
import 'package:tarefas/app/routes/app_routes.dart';
import 'package:tarefas/app/ui/android/home/home_screen.dart';
import 'package:tarefas/app/ui/android/login/login_screen.dart';
import 'package:tarefas/app/ui/android/splash/splash_screen.dart';

class Pages {
  static final routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => SplashScreenPage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
