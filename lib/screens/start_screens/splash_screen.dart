import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';

import 'package:flutter/material.dart';
import 'package:yahya_project/screens/start_screens/on_boarding.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(AppAssets.splashLogo,width: 267.42, height: 68.61,),
      ),
    );
  }
}
