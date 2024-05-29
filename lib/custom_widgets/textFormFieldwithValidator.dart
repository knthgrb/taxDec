// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tax/constants/colors.dart';

class CustomTextFormFieldWithValidator extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isNumberField;

  const CustomTextFormFieldWithValidator({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isNumberField,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters:
          isNumberField ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required.';
        }
        return null;
      },
    );
  }
}
