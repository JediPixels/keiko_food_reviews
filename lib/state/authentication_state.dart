import 'package:flutter/material.dart';

class AuthenticationState extends InheritedWidget {
  const AuthenticationState({super.key, required this.uid, required super.child});

  final String uid;

  static AuthenticationState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthenticationState>();
  }

  @override
  bool updateShouldNotify(AuthenticationState oldWidget) {
    return uid != oldWidget.uid;
  }
}