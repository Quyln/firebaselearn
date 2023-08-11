import 'package:firebaselearn/pages/login_screen.dart';
import 'package:firebaselearn/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showRegisterPage: toggle,
      );
    } else {
      return SignUpScreen(
        ShowLoginPage: toggle,
      );
    }
  }
}
