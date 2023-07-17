import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      this.title,
      this.buttonStyle,
      this.textStyle,
      this.onPressed});

  ButtonStyle? buttonStyle;
  TextStyle? textStyle;
  String? title;

  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: buttonStyle ??
            ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: onPressed,
        child: Text(
          title ?? 'Default',
          style: textStyle ??
              const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ));
  }
}
