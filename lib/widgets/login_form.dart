import 'package:flutter/material.dart';

import 'package:no_doubts_app/utils.dart';

class LoginForm extends StatelessWidget {

  LoginForm({ @required this.formKey, @required this.emailController, @required this.passwordController });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: this.formKey,
        child: Theme(
          data: ThemeData(
            primarySwatch: Colors.lightBlue,
            inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(
                color: Colors.lightBlue,
                fontSize: 20.0,
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: this.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  labelText: 'Digite seu email',
                  hintText: 'seu@email.com',
                ),
                validator: (value) => validateEmail(value),
              ),
              TextFormField(
                controller: this.passwordController,
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: 'Digite sua senha',
                  hintText: '********',
                ),
                validator: (value) => validatePassword(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}