import 'package:tarefas/app/data/models/home_model.dart';
import 'package:tarefas/app/data/provider/home_provider.dart';

class HomeRepository {
  final HomeProvider homeProvider = HomeProvider();

  Future<List<HomeModel>> getTasks() {
    return homeProvider.getTasks();
  }

  Future create(HomeModel model) {
    return homeProvider.create(model);
  }

  Future update(HomeModel model) {
    return homeProvider.update(model);
  }

  Future delete(int id) {
    return homeProvider.delete(id);
  }
}
