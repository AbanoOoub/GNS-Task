import 'package:flutter/material.dart';

import '../../helpers/app_colors.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm(
      {Key? key,
        required this.label,
        required this.hint,
        this.suffixIcon,
        this.hideCharacters = false,
        this.withBorders = false,
        this.readOnly = false,
        this.textInputType,
        this.textInputAction,
        this.textAlign = TextAlign.start,
        this.fillColor,
        this.labelColor,
        this.hintColor,
        this.textColor  ,
        this.controller,
        this.onChange,
        required this.validator , this.prefixIcon , this.onEditingComplete})
      : super(key: key);

  final TextEditingController? controller;
  final String label, hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool hideCharacters;
  final bool withBorders;
  final TextAlign textAlign;
  final FormFieldValidator<String> validator;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? textColor;
  final void Function(String)? onChange;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: labelColor ?? AppColors.mainColor),
        ),
        const SizedBox(height: 1),
        TextFormField(
          readOnly: readOnly,
          obscureText: hideCharacters,

          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          onChanged: onChange,
          textAlign: textAlign,
          validator: validator,
          onEditingComplete: onEditingComplete,
          style: TextStyle(
            color: textColor ?? AppColors.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: TextStyle(color: hintColor ?? AppColors.secondColor),
            filled: fillColor != null,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            errorBorder: withBorders
                ? OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.error, width: 0.5),
              borderRadius: BorderRadius.circular(8),
            )
                : InputBorder.none,
            border: withBorders
                ? OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(9),
            )
                : InputBorder.none,
          ),
        )
      ],
    );
  }
}