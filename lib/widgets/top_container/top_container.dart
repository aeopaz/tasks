import 'package:flutter/material.dart';
import 'package:bizzytasks_app/theme/colors/light_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainer(
      {this.height = 0,
      required this.width,
      required this.child,
      this.padding = const EdgeInsets.all(0.0)}); // Lo Modifique

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding, //!= null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: LightColors.kDarkYellow,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
