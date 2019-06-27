import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {

  SimpleButton({ @required this.text, @required this.width, @required this.onPressed });
  final String text;
  final double width;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      margin: EdgeInsets.all(20.0),
      child: RaisedButton(
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        onPressed: this.onPressed,
        color: Colors.lightBlue,
      ),
    );
  }
}