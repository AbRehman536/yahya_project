import 'package:flutter/material.dart';
import 'package:yahya_project/screens/auth/signup_screen.dart';
import 'package:yahya_project/screens/home/bottom_bar.dart';
import 'package:yahya_project/screens/home/home_screen.dart';
import 'package:yahya_project/services/authService.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_button.dart';
import 'package:yahya_project/widgets/custom_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
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
            Text("Reset Password",style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor
            ),),
            SizedBox(height: 10,),
            Text("Enter your email",
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
              controller: emailController,
              hintText: "abdullah@gmail.com",
            ),
            SizedBox(height: 10,),
            isLoading ? Center(child: CircularProgressIndicator(),):
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                  buttonLabel: "Reset Password",
                  onPressed: ()async{
                    try{
                      isLoading = true;
                      setState(() {});
                      await AuthService().resetPassword(
                          email: emailController.text,)
                          .then((value){
                        isLoading = false;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Successful"),
                              content: const Text("Link Send Successfully"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Okay"),
                                )
                              ],
                            );
                          },
                        );
                      });
                    }catch(e){
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));

                    }
                  }),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
