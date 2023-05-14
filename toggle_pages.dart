import 'package:fatwa/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:fatwa/sign_up.dart';

class TogglePages extends StatefulWidget {
  const TogglePages({super.key});

  @override
  State<TogglePages> createState() => _TogglePagesState();
}

class _TogglePagesState extends State<TogglePages> {
  bool showSignInPage = false;

  void switchScreen() {
    setState(() {
      showSignInPage = !showSignInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInPage) {
      return SignInPage(showSignUpPage: switchScreen);
    } else {
      return SignupPage(showSignInPage: switchScreen);
    }
  }
}
