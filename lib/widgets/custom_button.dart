import 'package:flutter/material.dart';
import 'package:yahya_project/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.buttonLabel,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      width: 353,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19)
          )
        ),
          onPressed: onPressed,
          child: Text(buttonLabel,style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.secondaryColor
          ),)),
    );
  }
}
