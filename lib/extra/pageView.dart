import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yahya_project/extra/models/onBoardingModel.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_button.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  int currentPage = 0;
  PageController pageController = PageController();
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
        image: AppAssets.onBoarding1,
        title: "Plan trip to more than 90 countries"),
    OnBoardingModel(
        image: AppAssets.onBoarding2,
        title: "Hassle free and quick flight booking"),
    OnBoardingModel(
        image: AppAssets.onBoarding3,
        title: "Real time flight status to keep you inform"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index){
                setState(() {
                  currentPage = index;
                });
              },
              //scrollDirection: Axis.vertical,
              controller: pageController,
              itemCount: onBoardingList.length,
              itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 90,),
                  Image.asset(onBoardingList[index].image.toString(),
                  width: double.infinity,height: 300,),
                    SizedBox(height: 50,),
                    Text(onBoardingList[index].title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkColor
                    ),),

                  ],),
              );
            },),
          ),
          SizedBox(height: 30,),
          SmoothPageIndicator(
              controller: pageController,  // PageController
              count:  onBoardingList.length,
              effect:  JumpingDotEffect(),  // your preferred effect
              onDotClicked: (index){
              }
          ),
          SizedBox(height: 30,),
          CustomButton(buttonLabel:
          currentPage == onBoardingList.length - 1 ? "Get Started" : "Next",
              onPressed: (){
            if(currentPage == onBoardingList.length - 1){
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(title: Text("Thank You"),);
              }, );
            }
            else{
              pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }
          }),
          SizedBox(height: 20,),
          TextButton(onPressed: (){}, child: Text("Sign Up")),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}
