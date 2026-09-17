import 'package:flutter/material.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_button.dart';
import 'package:yahya_project/widgets/custom_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70,),
            Align(
                alignment: Alignment.center,
                child: Image.asset(AppAssets.carrotImage,width: 47,height: 55,)),

            SizedBox(height: 27,),
            Text("Login",style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.darkColor
            ),),
            SizedBox(height: 10,),
            Text("Enter your email and password",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: AppColors.greyColor
            ),),
            SizedBox(height: 20,),
            Text("Email",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.greyColor
              ),),
            CustomField(
                hintText: "abdullah@gmail.com",
            ),
            SizedBox(height: 10,),
            Text("Password",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.greyColor
              ),),
            CustomField(
                hintText: "*********",
              suffixIcon: Icon(Icons.visibility_off),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Forget Password?",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: AppColors.darkColor
                ),),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                  buttonLabel: "Login",
                  onPressed: (){}),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkColor
                  ),),
                TextButton(onPressed: (){}, child: Text("Sign Up",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor
                  ),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
