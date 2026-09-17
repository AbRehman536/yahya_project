import 'package:flutter/material.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.onBoarding,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 500,
            left: 80,
            child: Text("Welcome \n"
                "to our store",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: AppColors.secondaryColor
            ),),
          ),
          Positioned(
            top: 650,
            left: 50,
            child: Text("Get your groceries in as fast as one hour",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.silverColor
              ),),
          ),
          Positioned(
            top: 710,
            left: 20,
            child: CustomButton(
                buttonLabel: "Get Started",
                onPressed: (){}),
          )
        ],
      ),
    );
  }
}
