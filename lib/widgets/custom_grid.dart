import 'package:flutter/material.dart';
import 'package:yahya_project/utils/app_colors.dart';

class CustomGrid extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double price;
  const CustomGrid({
    super.key, required this.image, required this.title, required this.description, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173,
      decoration: BoxDecoration(
        borderRadius: .circular(18),
        color: AppColors.secondaryColor,
        border: Border.all(
          color: AppColors.greyColor,
          width: 0.4
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.asset(image,width: 90,height: 90,),
            SizedBox(height: 5,),
            Text(title,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.darkColor
            ),),
            SizedBox(height: 5,),
            Text(description,style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: AppColors.greyColor
            ),),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text("\$$price"),
                FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.secondaryColor,
                  onPressed: (){},child: Icon(Icons.add),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
