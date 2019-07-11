import 'package:flutter/material.dart';

import 'package:no_doubts_app/api/user_api.dart';
import 'package:no_doubts_app/utils/token_storage.dart';

import 'package:no_doubts_app/pages/sign_up_page.dart';
import 'package:no_doubts_app/pages/home_page.dart';

import 'package:no_doubts_app/widgets/page_wrapper.dart';
import 'package:no_doubts_app/widgets/logo_header.dart';
import 'package:no_doubts_app/widgets/login_form.dart';
import 'package:no_doubts_app/widgets/simple_button.dart';
import 'package:no_doubts_app/widgets/link_to_screen.dart';
import 'package:no_doubts_app/widgets/conditional_message.dart';

class LoginPage extends StatefulWidget {
  final TokenStorage storage;

  LoginPage({ Key key, @required this.storage }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var accessToken;
  var refreshToken;

  var signUpResult;
  var isLoading;
  var apiError;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.storage.readToken(ACCESS_TOKEN_FILE).then((String access) {
      if (access != '') {
        widget.storage.readToken(REFRESH_TOKEN_FILE).then((String refresh) {
          if (refresh != '') {
            this.navigateToHomePage(context);
          }
        });
      }
    });

    isLoading = false;
    apiError = '';
    signUpResult = false;
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      login(emailController.text, passwordController.text)
        .then((result) {
          final accessToken = result["access_token"];
          final refreshToken = result["refresh_token"];

          widget.storage.writeTokenToFile(accessToken, ACCESS_TOKEN_FILE);
          widget.storage.writeTokenToFile(refreshToken, REFRESH_TOKEN_FILE);
          
          this.navigateToHomePage(context);
        })
        .catchError((error) {
          setState(() {
            apiError = 'Erro ao fazer login, verifique se os dados estão corretos';
            isLoading = false;
          });
        });
    }
  }

  void navigateToHomePage(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(storage: new TokenStorage())),
    );
  }

  void navigateToSignUpPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );

    setState(() {
      signUpResult = result;
    });
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
      page: isLoading
      ? Center(child: CircularProgressIndicator())
      : 
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LogoHeader(),
          ConditionalMessage(
            condition: this.signUpResult,
            message: "Usuário cadastrado com sucesso",
            textAlign: TextAlign.center,
            color: Colors.green[400],
          ),
          ConditionalMessage(
            condition: this.apiError != '',
            message: this.apiError,
            textAlign: TextAlign.center,
            color: Colors.redAccent,
          ),
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
              LinkToScreen(
                text: "Ainda não tem uma conta? Crie agora!",
                fontSize: 15.0,
                color: Colors.lightBlue[200],
                marginVertical: 10.0,
                onPressed: () => this.navigateToSignUpPage(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}