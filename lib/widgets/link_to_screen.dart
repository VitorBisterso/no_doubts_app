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
      margin: EdgeInsets.symmetric(vertical: this.marginVertical),
      child: InkWell(
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: this.fontSize,
            color: this.color,
          ),
        ),
        onTap: this.onPressed,
      ),
    );
  }
}