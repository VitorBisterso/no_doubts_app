import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

const ACCESS_TOKEN_FILE = 'jwta.txt';
const REFRESH_TOKEN_FILE = 'jwtr.txt';

class TokenStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<String> readToken(String fileName) async {
    try {
      final file = await _localFile(fileName);

      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<File> writeTokenToFile(String token, String fileName) async {
    final file = await _localFile(fileName);

    return file.writeAsString('$token');
  }
}