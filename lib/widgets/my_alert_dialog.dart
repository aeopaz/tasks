import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final Widget widgetMessage;
  final dynamic actions;
  MyAlertDialog(
      {required this.title,
      required this.widgetMessage,
      required this.actions});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: widgetMessage),
        actions: actions);
  }
}
