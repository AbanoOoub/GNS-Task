import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final Color btnBackgroundColor;
  final double borderSize;
  final double borderRadius;
  final bool hasBorder;
  final Color borderColor;
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const CustomTextButton({
    Key? key,
    required this.btnBackgroundColor,
    required this.hasBorder,
    required this.text,
    required this.onPressed,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.borderRadius = 10,
    this.borderSize = 1,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
          text: text,
          fontSize: fontSize,
          fontWeight: fontWeight,
          textColor: textColor),
      style: TextButton.styleFrom(
        backgroundColor: btnBackgroundColor,
        shape: hasBorder
            ? RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
              width: borderSize,
            ),
            borderRadius: BorderRadius.circular(borderRadius))
            : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}