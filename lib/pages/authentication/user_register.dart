import 'package:flutter/material.dart';
import 'package:keiko_food_reviews/helper/constants.dart';
import 'package:keiko_food_reviews/helper/validators.dart';
import 'package:keiko_food_reviews/logic/login_register_logic.dart';
import 'package:keiko_food_reviews/pages/authentication/user_login.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  static const String route = '/user_register';

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final LoginRegisterLogic _loginRegisterLogic = LoginRegisterLogic();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  @override
  void dispose() {
    _loginRegisterLogic.dispose();
    _email.dispose();
    _password.dispose();
    _passwordConfirm.dispose();
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
                  Image.asset('assets/images/shield_user.png', height: 80.0),
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
                            _loginRegisterLogic
                                .checkRegisterEmailAndPasswordAndConfirm(
                                    email: _email.text,
                                    password: _password.text,
                                    passwordConfirm: _passwordConfirm.text);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _password,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            icon: const Icon(Icons.password),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48.0)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (password) {
                            return Validators.password(password: password!)
                                ? null
                                : '6+ characters, 1 Number, 1 Uppercase, 1 Symbol';
                          },
                          onChanged: (password) {
                            _loginRegisterLogic
                                .checkRegisterEmailAndPasswordAndConfirm(
                                    email: _email.text,
                                    password: _password.text,
                                    passwordConfirm: _passwordConfirm.text);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordConfirm,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            icon: const Icon(Icons.password),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48.0)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (passwordConfirm) {
                            return Validators.password(
                                    password: passwordConfirm!)
                                ? null
                                : '6+ characters, 1 Number, 1 Uppercase, 1 Symbol';
                          },
                          onChanged: (passwordConfirm) {
                            _loginRegisterLogic
                                .checkRegisterEmailAndPasswordAndConfirm(
                                    email: _email.text,
                                    password: _password.text,
                                    passwordConfirm: _passwordConfirm.text);
                          },
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
                                  ? () => _loginRegisterLogic.register(
                                      email: _email.text,
                                      password: _password.text)
                                  : null,
                              style: ElevatedButton.styleFrom(elevation: 8.0),
                              child: const Text('Register'),
                            );
                          },
                        ),
                        // Show any register errors
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
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Expanded(child: Divider(endIndent: 16.0)),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(UserLogin.route),
                        child: const Text('I have a Login'),
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
