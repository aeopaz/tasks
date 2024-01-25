import 'package:bizzytasks_app/utilities/constants.dart';
import 'package:flutter/material.dart';

Future getDatePickerWidget(context, initialDate) {
  DateTime dateTimeInitial = kDateFormat.parse(initialDate);
  return showDatePicker(
    context: context,
    initialDate: dateTimeInitial,
    firstDate: DateTime(2024),
    lastDate: DateTime(2030),
    builder: (context, child) {
      return Theme(data: ThemeData.light(), child: child!);
    },
  );
}

Container myDateWidget({title, onPressed, dateString}) {
  return Container(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title),
      Row(
        children: [
          Text(dateString.toString()),
          TextButton(
            onPressed: onPressed,
            child: Icon(Icons.calendar_month),
          ),
        ],
      )
    ]),
  );
}
