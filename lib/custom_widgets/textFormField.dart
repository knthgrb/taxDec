// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tax/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? suffixText;
  final bool isNumberField;

  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.suffixText,
      required this.isNumberField});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters:
          isNumberField ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        suffixText: suffixText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
      ),
    );
  }
}
