import 'package:bizzytasks_app/models/list_app_model.dart';
import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final dynamic value;
  final Function(dynamic) onChanged;

  MyDropDownButton(
      {Key? key,
      required this.items,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
