import 'package:flutter/material.dart';

import 'package:no_doubts_app/utils/token_storage.dart';
import 'package:no_doubts_app/pages/login_page.dart';

void main() => runApp(MaterialApp(
  title: "No doubts",
  home: LoginPage(storage: new TokenStorage()),
  debugShowCheckedModeBanner: false,
));