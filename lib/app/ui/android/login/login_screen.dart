import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tarefas/app/controller/login_controller.dart';
import 'package:tarefas/app/data/repository/login_repository.dart';
import 'package:tarefas/app/routes/app_routes.dart';
import 'package:tarefas/app/ui/widgets/custom_icon_button.dart';
import 'package:tarefas/app/ui/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();

  final loginRepository = LoginRepository();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets\\Icon.png',
                      width: 130,
                      height: 130,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Card(
                  color: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Obx(
                          () => CustomTextField(
                            hint: 'User',
                            prefix: Icon(Icons.supervisor_account),
                            textInputType: TextInputType.emailAddress,
                            onChanged: _loginController.setEmail,
                            enabled: !_loginController.loading,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => CustomTextField(
                            hint: 'Password',
                            prefix: Icon(Icons.verified_user),
                            obscure: !_loginController.passwordVisible,
                            onChanged: _loginController.setPassword,
                            enabled: !_loginController.loading,
                            suffix: CustomIconButton(
                              radius: 32,
                              iconData: !_loginController.passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: _loginController.togglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(() {
                          return SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                primary: Theme.of(context).primaryColor,
                                onSurface: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(100),
                                onPrimary: Colors.white,
                              ),
                              child: _loginController.loading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : Text('Login'),
                              onPressed: _loginController.isEmailValid &&
                                      _loginController.isPasswordValid &&
                                      !_loginController.loading
                                  ? () {
                                      _clickButton(context);
                                    }
                                  : null,
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clickButton(BuildContext context) async {
    _loginController.toggleLoadin();
    var user = await loginRepository.login();

    if (user != null) {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }
}
