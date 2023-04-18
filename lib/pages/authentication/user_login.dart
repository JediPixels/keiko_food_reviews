import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/helper/validators.dart';
import 'package:keiko_food_reviews/logic/login_register_logic.dart';
import 'package:keiko_food_reviews/pages/authentication/user_forgot_password.dart';
import 'package:keiko_food_reviews/pages/authentication/user_register.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  static const String route = '/user_login';

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final LoginRegisterLogic _loginRegisterLogic = LoginRegisterLogic();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _loginRegisterLogic.dispose();
    _email.dispose();
    _password.dispose();
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
            )),
          ),
          SafeArea(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: ResponsiveSizes.mobile.value,
              child: Column(
                children: [
                  const SizedBox(height: 40.0),
                  Image.asset('assets/images/shield_yellow.png', height: 80.0),
                  const SizedBox(height: 72.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          textInputAction: TextInputAction.next,
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
                            _loginRegisterLogic.checkLoginEmailAndPassword(
                                email: _email.text, password: _password.text);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _password,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              icon: const Icon(Icons.password),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(48.0))),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (password) {
                            return Validators.password(password: password!)
                                ? null
                                : '6+ characters, 1 Number, 1 Uppercase, 1 Symbol';
                          },
                          onChanged: (password) {
                            _loginRegisterLogic.checkLoginEmailAndPassword(
                                email: _email.text, password: _password.text);
                          },
                          onFieldSubmitted: (password) =>
                              _loginRegisterLogic.login(
                                  email: _email.text, password: _password.text),
                        ),
                        const SizedBox(height: 32.0),

                        // Future the ListenableBuilder() will be released and we
                        // can replace the AnimatedBuilder()
                        AnimatedBuilder(
                          animation: _loginRegisterLogic,
                          builder: (BuildContext context, Widget? widget) {
                            return ElevatedButton(
                                onPressed: _loginRegisterLogic.loginRegisterInfo
                                        .buttonLoginRegisterEnabled
                                    ? () => _loginRegisterLogic.login(
                                        email: _email.text,
                                        password: _password.text)
                                    : null,
                                style: ElevatedButton.styleFrom(elevation: 8.0),
                                child: const Text('Login'));
                          },
                        ),

                        // Show login message errors
                        AnimatedBuilder(
                          animation: _loginRegisterLogic,
                          builder: (BuildContext context, Widget? widget) {
                            return Visibility(
                              visible: _loginRegisterLogic
                                  .loginRegisterInfo.showLoginRegisterError,
                              child: Column(
                                children: [
                                  const SizedBox(height: 24.0),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Divider(endIndent: 16.0)),
                                      Text(_loginRegisterLogic.loginRegisterInfo
                                          .loginRegisterErrorMessage
                                          .toString()),
                                      const Expanded(
                                          child: Divider(indent: 16.0))
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(UserForgotPassword.route),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Theme.of(context).disabledColor),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Expanded(child: Divider(endIndent: 16.0)),
                      Text(
                        'Don\'t have an account?',
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(UserRegister.route),
                        child: const Text('Create Account'),
                      ),
                      const Expanded(child: Divider(indent: 16.0)),
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
