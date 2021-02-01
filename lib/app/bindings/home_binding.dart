import 'package:get/get.dart';
import 'package:tarefas/app/controller/home_controller.dart';
import 'package:tarefas/app/data/repository/home_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeRepository>(() => HomeRepository());
  }
}
