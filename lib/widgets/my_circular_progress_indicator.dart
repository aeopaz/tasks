import 'package:flutter/material.dart';

//Por el momento sin usar
class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({
    Key? key,
    required AlwaysStoppedAnimation<Color> valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    );
  }
}
