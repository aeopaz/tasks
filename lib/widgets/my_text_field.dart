import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final bool obscureText;
  final Icon icon;
  final TextInputType inputType;
  final Function(dynamic) onChanged;
  final TextEditingController controller;
  MyTextField(
      {required this.label,
      this.maxLines = 1,
      this.minLines = 1,
      this.obscureText = false,
      this.inputType = TextInputType.name,
      required this.controller,
      required this.onChanged,
      this.icon = const Icon(Icons.abc)}); //Lo Modifique

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black87),
      keyboardType: inputType,
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscureText,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null : icon,
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
