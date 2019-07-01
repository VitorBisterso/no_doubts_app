import 'package:flutter/material.dart';

import 'package:no_doubts_app/widgets/page_wrapper.dart';
import 'package:no_doubts_app/widgets/logo_header.dart';
import 'package:no_doubts_app/widgets/sign_up_form.dart';
import 'package:no_doubts_app/widgets/simple_button.dart';
import 'package:no_doubts_app/widgets/link_to_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void submit() {
    if (this._formKey.currentState.validate()) {
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
      print('Confirm Password: ${confirmPasswordController.text}');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          SignUpForm(
            formKey: _formKey,
            emailController: emailController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),
          Column(
            children: <Widget>[
              SimpleButton(
                text: "Cadastrar",
                width: screenSize.width,
                paddingVertical: 10.0,
                fontSize: 20.0,
                onPressed: () => this.submit()
              ),
              LinkToPage(
                text: "Já tem uma conta? Faça login!",
                fontSize: 15.0,
                color: Colors.lightBlue[200],
                marginVertical: 10.0,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}