import 'package:flutter/material.dart';
import 'package:yahya_project/utils/app_colors.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const CustomField({super.key, required this.hintText, this.label, this.prefixIcon, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hint: Text(hintText),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        //label: Text(label!),
        // fillColor: AppColors.secondaryColor,
        // filled: true,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide(
        //     width: 1,
        //     color: AppColors.primaryColor
        //   )
        // )
      ),
    );
  }
}
