import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/firebase_options.dart';
import 'package:yahya_project/provider/theme_provider.dart';
import 'package:yahya_project/provider/user_provider.dart';
import 'package:yahya_project/screens/auth/login_screen.dart';
import 'package:yahya_project/screens/home/bottom_bar.dart';
import 'package:yahya_project/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Online Grocery App',
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,

          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: const Color(0xff121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff1e1e1e),
              foregroundColor: Colors.white,
            ),
          ),

          home: const LoginScreen(),
        );
      },
    );
  }
}
