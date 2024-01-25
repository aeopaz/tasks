import 'package:bizzytasks_app/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget(
      {required this.tittleButton,
      required this.onPressed,
      this.isLoading = false,
      this.disabled = false});

  final String tittleButton;
  final bool isLoading;
  final bool disabled;
  final Function onPressed;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          widget.isLoading || widget.disabled ? Colors.grey : LightColors.kBlue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () {
          if (widget.isLoading || widget.disabled) {
            return null;
          }
          widget.onPressed();
        },
        child: widget.isLoading
            ? MyProgressIndicator()
            : TextTitleButton(widget: widget),
      ),
    );
  }
}

class TextTitleButton extends StatelessWidget {
  const TextTitleButton({
    // super.key,
    required this.widget,
  });

  final ButtonWidget widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.tittleButton,
      style: const TextStyle(
          color: LightColors.kLightYellow,
          fontWeight: FontWeight.w700,
          fontSize: 18),
    );
  }
}

class MyProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    );
  }
}
