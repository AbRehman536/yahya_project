import 'package:flutter/material.dart';

import '../models/categoryModel.dart';
import '../services/categoryService.dart';
import '../utils/app_colors.dart';

class CustomCategoryContainer extends StatelessWidget {
  final String image;
  final String title;
  final String? categoryId;
  final CategoryModel? category;
  final VoidCallback? onEdit;


  const CustomCategoryContainer({
    super.key,
    required this.image,
    required this.title,
    this.categoryId,
    this.category,
    this.onEdit
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: .center,

      decoration: BoxDecoration(
        borderRadius: .circular(15),
        border: Border.all(width: 0.4, color: AppColors.greyColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Align(
              alignment: AlignmentGeometry.center,
              child: image.startsWith('http')
                  ? ClipRRect(
                borderRadius: .circular(20),
                child: Image.network(
                  image,
                  width:.infinity,
                  height: 150,
                  fit: .cover,
                  errorBuilder: (context , error ,stackTrace) =>
                      Icon(Icons.image_not_supported,size: 50,),
                ),
              )
                  : ClipRRect(
                borderRadius: .circular(20),
                child: Image.asset(image, width: .infinity,
                  height: 150,
                  fit: .cover,
                  errorBuilder: (context , error ,stackTrace) =>
                      Icon(Icons.image_not_supported,size: 50,)
                  ,
                ),
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: .center,
              child: Text(
                title,
                textAlign: .center,
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                //delete button start
                if(categoryId != null)
                  IconButton(onPressed: (){
                    try{
                      CategoryService().deleteCategory(
                          categoryId!
                      );
                    }catch(e){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }, icon: Icon(Icons.delete)),
                //delete button end

                if(categoryId != null)
                  IconButton(onPressed: ()
                  {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => UpdateCategoryScreen(category: category!,)));
                  }, icon: Icon(Icons.edit))
              ],
            )
          ],
        ),
      ),
    );
  }
}