import 'package:flutter/material.dart';

class LinkToScreen extends StatelessWidget {

  LinkToScreen({
    @required this.text,
    @required this.fontSize,
    @required this.onPressed,
    this.color = Colors.lightBlue,
    this.marginVertical = 0,
  });

  final String text;
  final double fontSize;
  final Function onPressed;
  final Color color;
  final double marginVertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVertical),
      child: InkWell(
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}