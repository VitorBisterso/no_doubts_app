import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {

  SimpleButton({
    @required this.text,
    @required this.width,
    @required this.fontSize,
    @required this.onPressed,
    this.backgroundColor = Colors.lightBlue,
    this.paddingVertical = 0,
    this.marginHorizontal = 0,
  });

  final String text;
  final double width;
  final double fontSize;
  final Function onPressed;
  final Color backgroundColor;
  final double paddingVertical;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: this.fontSize
          ),
        ),
        onPressed: this.onPressed,
        color: this.backgroundColor,
        padding: EdgeInsets.symmetric(vertical: this.paddingVertical),
      ),
    );
  }
}