import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/models/UserModel.dart';
import 'package:yahya_project/provider/user_provider.dart';
import 'package:yahya_project/screens/auth/reset_password.dart';
import 'package:yahya_project/screens/auth/signup_screen.dart';
import 'package:yahya_project/screens/home/bottom_bar.dart';
import 'package:yahya_project/screens/home/home_screen.dart';
import 'package:yahya_project/services/authService.dart';
import 'package:yahya_project/services/userService.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
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
              controller: emailController,
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
              controller: passwordController,
                hintText: "*********",
              suffixIcon: Icon(Icons.visibility_off),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPasswordScreen()));
                },
                child: Text("Forget Password?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColors.darkColor
                  ),),
              ),
            ),
            SizedBox(height: 10,),
            isLoading ? Center(child: CircularProgressIndicator(),):
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                  buttonLabel: "Login",
                  onPressed: ()async{
                    try{
                      isLoading = true;
                      setState(() {});
                      await AuthService().loginUser(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value)async{
                        UserModel userModel =
                        await UserService().getUserByID(value.uid.toString());
                        userProvider.setUser(userModel);
                        isLoading = false;
                        setState(() {});
                        if(value.emailVerified == true){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBarScreen()));
                        }
                        else{
                          showDialog(context: context, builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Kindly Verify Your Email"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Okay"))
                              ],
                            );
                          },);
                        }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkColor
                  ),),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
                }, child: Text("Sign Up",
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
