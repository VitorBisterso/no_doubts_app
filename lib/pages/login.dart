import 'package:flutter/material.dart';

import 'package:no_doubts_app/pages/sign_up.dart';

import 'package:no_doubts_app/widgets/page_wrapper.dart';
import 'package:no_doubts_app/widgets/logo_header.dart';
import 'package:no_doubts_app/widgets/login_form.dart';
import 'package:no_doubts_app/widgets/simple_button.dart';
import 'package:no_doubts_app/widgets/link_to_page.dart';

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

    return PageWrapper(
      pageColor: Colors.white,
      page: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LogoHeader(),
          LoginForm(
            formKey: _formKey,
            emailController: emailController,
            passwordController: passwordController
          ),
          Column(
            children: <Widget>[
              SimpleButton(
                text: "Entrar",
                width: screenSize.width,
                paddingVertical: 10.0,
                fontSize: 20.0,
                onPressed: () => this.submit()
              ),
              LinkToPage(
                text: "Ainda não tem uma conta? Crie agora!",
                fontSize: 15.0,
                color: Colors.lightBlue[200],
                marginVertical: 10.0,
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}