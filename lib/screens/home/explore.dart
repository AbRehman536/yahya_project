import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Widgets/custom_appbar.dart';
import '../../models/categoryModel.dart';
import '../../services/categoryService.dart';
import '../../utils/app_assets.dart';
import '../../widgets/explore_container.dart';
import '../admin/create_category.dart';
import 'beverages.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<CategoryModel> categoriesList = [
    CategoryModel(
      categoryImage: AppAssets.bananaImage,
      categoryName: "Fruits & Vegetables",
    ),
    CategoryModel(
      categoryImage: AppAssets.bananaImage,
      categoryName: "Fruits & Vegetables",
    ),
    CategoryModel(
      categoryImage: AppAssets.bananaImage,
      categoryName: "Fruits & Vegetables",
    ),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(title: "Explore",leading: Text("")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hint: Text("Search store"),
                fillColor: Color(0xffF2F3F2),
                filled: true,
                prefixIcon : Icon(Icons.search) ,
                border: OutlineInputBorder(
                  borderRadius: .circular(15),
                  borderSide: .none,
                ),
              ),
            ),
            SizedBox(height: 20),

            StreamProvider.value(value: CategoryService().getAllCategory(),
              initialData: [CategoryModel()],
              builder: (context , child){
                List<CategoryModel> categoryList = context.watch<List<CategoryModel>>();
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 280,
                    ),
                    itemCount: categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BeveragesScreen(model: categoryList[index],)));
                          },
                          child: CustomCategoryContainer(
                              category: categoryList[index],
                              categoryId: categoryList[index].docId.toString(),
                              image: (categoryList[index].categoryImage != null && categoryList[index].categoryImage!.isNotEmpty)
                                  ? categoryList[index].categoryImage!
                                  : categoriesList[index % categoriesList.length].categoryImage.toString()  ,
                              title: categoryList[index].categoryName.toString())
                        // Container(
                        //   width: 175,
                        //   height: 190,
                        //   decoration: BoxDecoration(
                        //       color: Colors.teal,
                        //       borderRadius: .circular(18),
                        //       border: Border.all(
                        //           color: Colors.black
                        //       )
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(20.0),
                        //     child: Column(
                        //       mainAxisAlignment: .center,
                        //       crossAxisAlignment: .center,
                        //       children: [
                        //         Image.asset(
                        //           (categoryList[index].categoryImage != null && categoryList[index].categoryImage!.isNotEmpty)
                        //               ? categoryList[index].categoryImage!
                        //               : categoriesList[index % categoriesList.length].categoryImage.toString(),
                        //           width: 115,
                        //           height: 78,
                        //         ),
                        //         SizedBox(height: 20),
                        //         Text(
                        //           categoryList[index].categoryName.toString(),
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w900,
                        //             fontSize: 18,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      );
                    },
                  ),
                );
              },
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCategoryScreen()));
      },child: Icon(Icons.add),),
    );
  }
}