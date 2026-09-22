import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:yahya_project/extra/app_bar/app_bar.dart';
import 'package:yahya_project/screens/auth/login_screen.dart';
import 'package:yahya_project/screens/home/beverages.dart';
import 'package:yahya_project/screens/home/explore.dart';
import 'package:yahya_project/screens/home/favorite.dart';
import 'package:yahya_project/screens/home/filter.dart';
import 'package:yahya_project/screens/home/my_cart.dart';
import 'package:yahya_project/screens/profile/profile_screen.dart';
import 'package:yahya_project/screens/start_screens/on_boarding.dart';
import 'package:yahya_project/screens/start_screens/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // Device Preview configuration
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      home: MyCartScreen(),
    );
  }
}