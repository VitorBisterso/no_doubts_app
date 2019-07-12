import 'dart:io';

import 'package:http/http.dart';

import 'package:no_doubts_app/api/user_api.dart';
import 'package:no_doubts_app/api/endpoints.dart';
import 'package:no_doubts_app/utils/internal_storage.dart';
import 'package:no_doubts_app/utils/utils.dart';

Future getDoubts(String email, List<String> tokens) async {
  final accessToken = tokens.elementAt(0);
  Response response = await get(
    '$BASE_URL/$GET_DOUBTS?user=$email',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    },
  );

  return response.statusCode == 401 ? refreshToken(tokens.elementAt(1)) : response.body;
}

Future refreshToken(String refreshToken) async {
  refreshAccessToken(refreshToken).then((String newAccessToken) {
    if (newAccessToken != '') {
      final storage = new InternalStorage();
      storage.writeStringToFile(newAccessToken, ACCESS_TOKEN_FILE);
      return RETRY;
    } else {
      return '';
    }
  });
}
