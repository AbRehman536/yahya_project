import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<ProductModel> productList = [
    ProductModel(
        image: AppAssets.product1Image,
        title: "Fruits & Vegetables",
        color: Color(0xff53B175).withOpacity(0.2)
    ),
    ProductModel(
        image: AppAssets.product2Image,
        title: "Cooking Oil & Ghee",
        color: Color(0xffF8A44C).withOpacity(0.2)
    ),
    ProductModel(
        image: AppAssets.product1Image,
        title: "Fruits & Vegetables",
        color: Color(0xff53B175).withOpacity(0.2)
    ),
    ProductModel(
        image: AppAssets.product2Image,
        title: "Cooking Oil & Ghee",
        color: Color(0xffF8A44C).withOpacity(0.2)
    ),
    ProductModel(
        image: AppAssets.product1Image,
        title: "Fruits & Vegetables",
        color: Color(0xff53B175).withOpacity(0.2)
    ),
    ProductModel(
        image: AppAssets.product2Image,
        title: "Cooking Oil & Ghee",
        color: Color(0xffF8A44C).withOpacity(0.2)
    ),
    ProductModel(
        image: AppAssets.product1Image,
        title: "Fruits & Vegetables",
        color: Color(0xff53B175).withOpacity(0.2)
    ),
    ProductModel(
        image: AppAssets.product2Image,
        title: "Cooking Oil & Ghee",
        color: Color(0xffF8A44C).withOpacity(0.2)
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: "Find Products",
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(15.sp),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                fillColor: Color(0xffF2F3F2),
                filled: true,
                hint: Text("Search Store"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: .circular(15.r),
                  borderSide: .none
                )
              ),
            ),
            SizedBox(height: 15.h,),
            const Spacer(),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    mainAxisExtent: 189.h
                  ),
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 189.h,
                      width: 174.w,
                      decoration: BoxDecoration(
                        color: productList[index].color,
                        borderRadius: .circular(18.r),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(15.sp),
                        child: Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .center,
                          children: [
                            Image.asset(productList[index].image.toString(),
                            width: 100.w,height: 70.h,),
                            SizedBox(height: 20.h,),
                            Text(productList[index].title.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkColor
                            ),),
                          ],
                        ),
                      ),
                    );
                },
                  ),
            )
          ],
        ),
      ),
    );
  }
}
