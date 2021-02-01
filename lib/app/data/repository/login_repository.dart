import 'package:tarefas/app/data/provider/login_provider.dart';

class LoginRepository {
  final LoginProvider loginProvider = LoginProvider();

  Future login() {
    return loginProvider.login();
  }
}
