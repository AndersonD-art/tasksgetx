import 'package:get/get.dart';

class LoginController extends GetxController {
  final _passwordVisible = false.obs;
  get passwordVisible => this._passwordVisible.value;
  set passwordVisible(value) => this._passwordVisible.value = value;

  final _password = "".obs;
  get password => this._password.value;
  set password(value) => this._password.value = value;

  final _email = "".obs;
  get email => this._email.value;
  set email(value) => this._email.value = value;

  final _loading = false.obs;
  get loading => this._loading.value;
  set loading(value) => this._loading.value = value;

  bool get isEmailValid => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);

  void setEmail(String value) => email = value;

  bool get isPasswordValid => password.length >= 3;

  void setPassword(String value) => password = value;

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
  }

  void toggleLoadin() => loading = !loading;

  void cleanEmail() => email = "";
}
