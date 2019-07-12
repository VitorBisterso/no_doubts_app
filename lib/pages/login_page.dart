import 'package:flutter/material.dart';

import 'package:no_doubts_app/api/user_api.dart';
import 'package:no_doubts_app/utils/internal_storage.dart';

import 'package:no_doubts_app/pages/sign_up_page.dart';
import 'package:no_doubts_app/pages/home_page.dart';

import 'package:no_doubts_app/widgets/page_wrapper.dart';
import 'package:no_doubts_app/widgets/logo_header.dart';
import 'package:no_doubts_app/widgets/login_form.dart';
import 'package:no_doubts_app/widgets/simple_button.dart';
import 'package:no_doubts_app/widgets/link_to_screen.dart';
import 'package:no_doubts_app/widgets/conditional_message.dart';

class LoginPage extends StatefulWidget {
  final InternalStorage storage;

  LoginPage({ Key key, @required this.storage }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var signUpResult;
  var isLoading;
  var apiError;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.storage.readTokens().then((List<String> tokens) {
      if (tokens.elementAt(0) != '' && tokens.elementAt(1) != '') {
        widget.storage.readFile(EMAIL_FILE).then((String email) {
          if (email != '') {
            this.navigateToHomePage(context, email, tokens);
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

          widget.storage.writeTokens(accessToken, refreshToken);
          widget.storage.writeStringToFile(emailController.text, EMAIL_FILE);
          
          List<String> tokens = new List<String>();
          tokens.add(accessToken);
          tokens.add(refreshToken);
          this.navigateToHomePage(context, emailController.text, tokens);
        })
        .catchError((error) {
          setState(() {
            apiError = 'Erro ao fazer login, verifique se os dados estão corretos';
            isLoading = false;
          });
        });
    }
  }

  void navigateToHomePage(BuildContext context, String userEmail, List<String> tokens) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(
        storage: new InternalStorage(),
        userEmail: userEmail,
        tokens: tokens,
      )),
    );
  }

  void navigateToSignUpPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );

    setState(() {
      signUpResult = result;
      apiError = '';
      isLoading = false;
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