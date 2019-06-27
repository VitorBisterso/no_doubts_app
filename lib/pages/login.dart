import 'package:flutter/material.dart';

import 'package:no_doubts_app/widgets/login_header.dart';
import 'package:no_doubts_app/widgets/login_form.dart';
import 'package:no_doubts_app/widgets/simple_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submit() {
    if (this._formKey.currentState.validate()) {
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            LoginHeader(),
            LoginForm(
              formKey: _formKey,
              emailController: emailController,
              passwordController: passwordController
            ),
            SimpleButton(
              text: 'Login',
              width: screenSize.width,
              onPressed: () => this.submit()
            ),
          ],
        ),
      ),
    );
  }
}