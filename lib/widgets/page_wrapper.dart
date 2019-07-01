import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {

  PageWrapper({ @required this.pageColor, @required this.page });
  final Color pageColor;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          backgroundColor: this.pageColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight * 0.9,
                ),
                child: this.page,
              )
            )
          )
        );
      }
    );
  }
}