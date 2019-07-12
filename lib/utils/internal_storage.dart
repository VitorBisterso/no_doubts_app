import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

const ACCESS_TOKEN_FILE = 'jwta.txt';
const REFRESH_TOKEN_FILE = 'jwtr.txt';
const EMAIL_FILE = 'e.txt';

class InternalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<String> readFile(String fileName) async {
    try {
      final file = await _localFile(fileName);

      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeStringToFile(String str, String fileName) async {
    final file = await _localFile(fileName);

    return file.writeAsString('$str');
  }
  
  Future<List<String>> readTokens() async {
    List<String> result = new List<String>();

    result.add(await readFile(ACCESS_TOKEN_FILE));
    result.add(await readFile(REFRESH_TOKEN_FILE));

    return result;
  }

  Future<void> writeTokens(String accessToken, String refreshToken) async {
    writeStringToFile(accessToken, ACCESS_TOKEN_FILE);
    writeStringToFile(refreshToken, REFRESH_TOKEN_FILE);
  }
}