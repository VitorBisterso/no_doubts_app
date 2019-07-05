import 'dart:io';

import 'package:http/http.dart';
import 'package:password/password.dart';

import 'package:no_doubts_app/models/user_model.dart';
import 'package:no_doubts_app/api/endpoints.dart';

Future<User> signUp(String email, String password) async {
  final encryptedPassword = Password.hash(password, PBKDF2());

  User user = new User(user: email, password: encryptedPassword);

  Response response = await post(
    '$BASE_URL/$SIGN_UP',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: userToJson(user),
  );

  return userFromJson(response.body);
}