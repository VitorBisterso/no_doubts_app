import 'package:flutter/material.dart';

import 'package:no_doubts_app/api/user_api.dart';

import 'package:no_doubts_app/widgets/page_wrapper.dart';
import 'package:no_doubts_app/widgets/logo_header.dart';
import 'package:no_doubts_app/widgets/sign_up_form.dart';
import 'package:no_doubts_app/widgets/simple_button.dart';
import 'package:no_doubts_app/widgets/link_to_screen.dart';
import 'package:no_doubts_app/widgets/conditional_message.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var apiError = false;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void submit() {
    if (this._formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      signUp(emailController.text, passwordController.text)
        .then((_) {
          Navigator.pop(context, true);
        })
        .catchError((_) {
          setState(() {
            apiError = true;
            isLoading = false;
          });
        });
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
      page: isLoading
      ? Center(
          child: CircularProgressIndicator(),
        )
      :
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            LogoHeader(),
            ConditionalMessage(
              condition: this.apiError,
              message: "Erro ao cadastrar usuário, tente novamente",
              textAlign: TextAlign.center,
              color: Colors.redAccent,
            ),
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
                LinkToScreen(
                  text: "Já tem uma conta? Faça login!",
                  fontSize: 15.0,
                  color: Colors.lightBlue[200],
                  marginVertical: 10.0,
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ),
          ],
        ),
    );
  }
}