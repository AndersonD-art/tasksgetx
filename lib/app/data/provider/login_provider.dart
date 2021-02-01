class LoginProvider {
  Future<void> login() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
