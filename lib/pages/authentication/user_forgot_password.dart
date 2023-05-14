import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/helper/validators.dart';
import 'package:keiko_food_reviews/logic/login_register_logic.dart';
import 'package:keiko_food_reviews/pages/authentication/user_login.dart';
import 'package:keiko_food_reviews/services/authentication_service.dart';

class UserForgotPassword extends StatefulWidget {
  const UserForgotPassword({super.key});

  static const String route = '/user_forgot_password';

  @override
  State<UserForgotPassword> createState() => _UserForgotPasswordState();
}

class _UserForgotPasswordState extends State<UserForgotPassword> {
  final LoginRegisterLogic _loginRegisterLogic = LoginRegisterLogic();
  final TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _loginRegisterLogic.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                ],
                stops: const [0.0, 0.4],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: ResponsiveSizes.mobile.value,
              child: Column(
                children: [
                  const SizedBox(height: 48.0),
                  Image.asset(
                    'assets/images/shield_question.png',
                    height: 80.0,
                  ),
                  const SizedBox(height: 80.0),
                  TextFormField(
                    controller: _email,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: const Icon(Icons.mail_outline),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) {
                      return Validators.email(email: email!)
                          ? null
                          : 'Enter a valid email';
                    },
                    onChanged: (email) {
                      _loginRegisterLogic.checkLoginEmail(email: _email.text);
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ListenableBuilder(
                    listenable: _loginRegisterLogic,
                    builder: (BuildContext context, Widget? widget) {
                      return ElevatedButton(
                        onPressed: _loginRegisterLogic
                                .loginRegisterInfo.buttonLoginRegisterEnabled
                            ? () {
                                AuthenticationService.sendPasswordReset(
                                        _email.text)
                                    .then((emailSent) {
                                  if (emailSent == true) {
                                    Navigator.of(context)
                                        .pushReplacementNamed(UserLogin.route);
                                  }
                                });
                              }
                            : null,
                        child: const Text('Reset Password'),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    children: [
                      const Expanded(child: Divider(endIndent: 16.0)),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(UserLogin.route),
                        child: Text('Login',
                            style: TextStyle(
                                color: Theme.of(context).disabledColor)),
                      ),
                      const Expanded(child: Divider(indent: 16.0)),
                    ],
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
