import 'package:flutter/material.dart';
import 'package:yahya_project/models/UserModel.dart';
import 'package:yahya_project/services/authService.dart';
import 'package:yahya_project/services/userService.dart';
import 'package:yahya_project/widgets/custom_button.dart';
import 'package:yahya_project/widgets/custom_field.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Align(
                alignment: Alignment.center,
                child: Image.asset(AppAssets.carrotImage , width: 47 , height: 55,)),
            SizedBox(height: 60,),
            Text("Sign Up",style: TextStyle(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w900,
              fontSize: 26,
            ),),
            SizedBox(height: 10,),
            Text("Enter your Credentials to continue",style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 16
            ),),
            SizedBox(height: 25,),
            Text("Username",style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 16,
                fontWeight: FontWeight.w900
            ),),
            CustomField(
                controller: nameController,
                hintText: "Yahya Khan"),
            SizedBox(height: 30,),
            Text("Email",style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 16,
                fontWeight: FontWeight.w900
            ),),
            CustomField(
              controller: emailController,
              hintText: "yahyakhan@gmail.com",suffixIcon: Icon(
              Icons.check,
              color: AppColors.primaryColor,
            ),),
            SizedBox(height: 30,),
            Text("Password",style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 16,
                fontWeight: FontWeight.w900
            ),),
            CustomField(
              controller: passwordController,
              hintText: "*********",suffixIcon: Icon(
                Icons.visibility_off_outlined
            ),),
            SizedBox(height: 10,),
            RichText(
                text: TextSpan(
              children: [
                TextSpan(
                  text: "By Continuing you agree to our ",
                  style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                ),
                TextSpan(
                  text: "Terms of Service ",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                ),
                TextSpan(
                  text: "and ",
                    style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),
                ),
                TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                )
              ]
            )),
            SizedBox(height: 20,),
            isLoading ? Center(child: CircularProgressIndicator(),):
            Align(
                alignment: Alignment.center,
                child: CustomButton(buttonLabel: "Sign Up", onPressed: ()async {
                  if(nameController.text.isEmpty){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Please Enter Your Name")));
                        return;
                  }
                  if(emailController.text.isEmpty){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Please Enter Your Email")));
                        return;
                  }
                  if(passwordController.text.isEmpty){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Please Enter Your Password")));
                        return;
                  }
                  if(passwordController.text.length < 8){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Password must be more than 8 digits")));
                        return;
                  }
                  try{
                    isLoading = true;
                    setState(() {});
                    await AuthService().registerUser(
                        email: emailController.text,
                        password: passwordController.text)
                        .then((val)async{
                          await UserService().createUser(
                            UserModel(
                              docId: val.uid.toString(),
                              userName: nameController.text,
                              userEmail: emailController.text,
                              createdAt: DateTime.now().millisecondsSinceEpoch
                            )
                          ).then((val){
                            isLoading = false;
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Successful"),
                                  content: const Text("Register Successfully"),
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
                    });
                  }catch(e){
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },)),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",style: TextStyle(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 14
                ),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen()));
                }, child: Text("Login",style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14
                ),))
              ],
            )
          ],
        ),
      ),
    );
  }
}