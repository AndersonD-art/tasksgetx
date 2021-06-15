class LoginProvider {
  Future<bool> login() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
