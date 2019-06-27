import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25.0),
        ),
        Image.asset(
          'assets/icon.png',
          fit: BoxFit.contain,
          width: 75.0,
        ),
        Text(
          "No doubts",
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ],
    );
  }
}