import 'package:get/get.dart';
import 'package:tarefas/app/data/models/home_model.dart';
import 'package:tarefas/app/data/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = Get.find<HomeRepository>();

  List<HomeModel> listModel = <HomeModel>[].obs;

  List tasks = [].obs;

  final _newTasksTitle = "".obs;
  get newTasksTitle => this._newTasksTitle.value;
  set newTasksTitle(value) => this._newTasksTitle.value = value;

  void setNewTodoTitle(String value) => newTasksTitle = value;

  bool get isFormValid => newTasksTitle.isNotEmpty;

  bool get isListValid => listModel.isNotEmpty;

  loadTask() async {
    final resp = await _homeRepository.getTasks();
    listModel = resp;
    update();
  }

  addTask({HomeModel? recover, HomeModel? edit}) async {
    tasks = [].obs;
    if (recover == null && edit == null) {
      var data = await _homeRepository.create(
        HomeModel(
          name: newTasksTitle,
          date: DateTime.now().toString(),
        ),
      );
      tasks.add(data);
    } else if (recover != null && edit == null) {
      var data = await _homeRepository.create(
        HomeModel(
          name: recover.name,
          date: recover.date,
        ),
      );
      tasks.add(data);
    } else {
      tasks = await _homeRepository.update(
        HomeModel(
          id: edit!.id,
          name: edit.name,
          date: edit.date,
        ),
      );
    }
  }

  updateTask({required HomeModel edit}) async {
    listModel = await _homeRepository.update(edit);
  }

  dellTask(int id) async {
    tasks = await _homeRepository.delete(id);
  }
}
