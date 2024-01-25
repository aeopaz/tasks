import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem> items;
  final dynamic value;
  final String orientation;
  final dynamic width;
  final Function(dynamic) onChanged;

  MyDropDownButton(
      {Key? key,
      required this.title,
      required this.items,
      required this.value,
      required this.onChanged,
      this.width = null,
      this.orientation = 'row'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orientation == 'row') {
      return Row(
        children: listWidget(),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listWidget(),
    );
  }

  List<Widget> listWidget() {
    return [
      Text(title),
      SizedBox(
        width: 10,
      ),
      Container(
        width: width == null ? double.infinity : width,
        child: DropdownButton(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          style: TextStyle(fontSize: 15.0, color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
    ];
  }
}
