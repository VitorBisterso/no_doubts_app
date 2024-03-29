import 'package:flutter/material.dart';

class ConditionalMessage extends StatelessWidget {

  ConditionalMessage({
    @required this.condition,
    @required this.message,
    this.textAlign = TextAlign.left,
    this.color = Colors.black
  });

  final bool condition;
  final String message;
  final TextAlign textAlign;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return condition ? Text(
      message,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 20.0,
        color: color,
      )
    ) : Container();
  }
}