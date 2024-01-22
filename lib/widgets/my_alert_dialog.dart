import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final Widget widgetMessage;
  MyAlertDialog(this.title, this.widgetMessage);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: widgetMessage,
      actions: [
        TextButton(
          child: Text('Cerrar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
