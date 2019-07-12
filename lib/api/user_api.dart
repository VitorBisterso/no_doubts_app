import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';

import 'package:no_doubts_app/models/user_model.dart';
import 'package:no_doubts_app/api/endpoints.dart';

Future<User> signUp(String email, String password) async {
  User user = new User(user: email, password: password);

  Response response = await post(
    '$BASE_URL/$SIGN_UP',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: userToJson(user),
  );

  return userFromJson(response.body);
}

Future<Map<String, dynamic>> login(String email, String password) async {
  User user = new User(user: email, password: password);

  Response response = await post(
    '$BASE_URL/$LOGIN',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: userToJson(user),
  );

  return json.decode(response.body);
}

Future<void> logout(List<String> tokens) async {
  String accessToken = tokens.elementAt(0);
  String refreshToken = tokens.elementAt(1);

  await delete(
    '$BASE_URL/$LOGOUT_ACCESS',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    },
  );

  await delete(
    '$BASE_URL/$LOGOUT_REFRESH',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $refreshToken',
    },
  );
}

Future<String> refreshAccessToken(String refreshToken) async {
  Response response = await post(
    '$BASE_URL/$REFRESH_ACCESS_TOKEN',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $refreshToken',
    },
  );

  return response.statusCode == 200 ? json.decode(response.body)["access_token"] : '';
}
