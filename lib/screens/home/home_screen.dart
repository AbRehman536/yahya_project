import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/screens/admin/create_product.dart';
import 'package:yahya_project/services/productService.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
///images list
class _HomeScreenState extends State<HomeScreen> {
  List<String> imagesList = [
    AppAssets.slide1Image,
    AppAssets.slide2Image,
    AppAssets.slide2Image,
  ];
  ///Data About productCards
  List<CustomContainer> exclusiveList = [
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Organic Bananas",
        subTitle: "7pcs, Price",
        price: 4.99
    ),
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Red Apple",
        subTitle: "1kg, Price",
        price: 4.99
    ),
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Organic Bananas",
        subTitle: "7pcs, Price",
        price: 4.99
    ),
  ];

  List<CustomContainer> sellingList = [
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Bell pepper Red",
        subTitle: "1kg, Price",
        price: 4.99
    ),
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Ginger",
        subTitle: "250gram, Price",
        price: 4.99
    ),
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Organic Bananas",
        subTitle: "7pcs, Price",
        price: 4.99
    ),
  ];

  // List<CustomGroceriesRow> groceriesList = [
  //   CustomGroceriesRow(
  //       image: AppAssets.pulsesImage,
  //       title: "Pulses",
  //       color: Color(0xffF8A44C)
  //   ),
  //   CustomGroceriesRow(
  //       image: AppAssets.riceImage,
  //       title: "Rice",
  //       color: Color(0xff53B175)
  //   ),
  // ];

  List<CustomContainer> lastList = [
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Beef Bone",
        subTitle: "1kg, Price",
        price: 4.99
    ),
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Boiler Chicken",
        subTitle: "1kg, Price",
        price: 4.99
    ),
    CustomContainer(
        image: AppAssets.bananaImage,
        title: "Beef",
        subTitle: "10kg, Price",
        price: 4.99
    ),
  ];
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProduct()));
      },child: Icon(Icons.add),),
      backgroundColor: Colors.white,
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .center,
            children: [ /// top
              SizedBox(height: 40),
              Image.asset(AppAssets.carrotImage, width: 30, height: 30),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: Color(0xff4C4F4D),
                    fontWeight: FontWeight.w900,
                  ),
                  Text(
                    "Swat , Pakistan",
                    style: TextStyle(
                      color: Color(0xff4C4F4D),
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  fillColor: Color(0xffF2F3F2),
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  hint: Text("Search store"),
                  border: OutlineInputBorder(
                    borderRadius: .circular(16),
                    borderSide: .none,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ///Middle
              CarouselSlider(
                items: imagesList.map((images) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(images),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: .circular(16)
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 150,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      selectedImage = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Exclusive Offer",style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: AppColors.darkColor
                  ),),
                  TextButton(onPressed: (){}, child: Text("See all",style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),))
                ],
              ),
              SizedBox(height: 10,),
              StreamProvider.value(
                  value: ProductService().getAllProduct(),
                  initialData: [ProductModel()],
                  builder: (context, child){
                    List<ProductModel> productList = context.watch<List<ProductModel>>();
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                          itemCount: productList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: (){
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context)=> ProductDetailScreen())
                                  // );
                                },
                                child: CustomContainer(
                                   productID: productList[index].docId.toString(),
                                    image: exclusiveList[index].image.toString(),
                                    title: productList[index].productName.toString(),
                                    subTitle: productList[index].productWeight.toString(),
                                    price: double.parse(productList[index].productPrice.toString())),
                              ),
                            );
                          }),
                    );
                  },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Best Selling",style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: AppColors.darkColor
                  ),),
                  TextButton(onPressed: (){}, child: Text("See all",style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),))
                ],
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 250,
                child: ListView.builder(

                    itemCount: sellingList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: (){
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailScreen()));
                          },
                          child: CustomContainer(
                              image: sellingList[index].image.toString(),
                              title: sellingList[index].title.toString(),
                              subTitle: sellingList[index].subTitle.toString(),
                              price: sellingList[index].price),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Groceries",style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: AppColors.darkColor
                  ),),
                  TextButton(onPressed: (){}, child: Text("See all",style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),))
                ],
              ),
              SizedBox(height: 10,),
              // SizedBox(
              //   height: 125,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: groceriesList.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.only(right: 12),
              //         child: Container(
              //           width: 248,
              //           height: 105,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(16),
              //             color: groceriesList[index].color.withOpacity(0.3),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Image.asset(
              //                 groceriesList[index].image,
              //                 width: 71,
              //                 height: 71,
              //               ),
              //               const SizedBox(width: 18),
              //               Text(
              //                 groceriesList[index].title,
              //                 style: const TextStyle(
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w900,
              //                   color: Color(0xff3E423F),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              SizedBox(height: 10,),

              SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: lastList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: (){
                           // Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetailScreen()));
                          },
                          child: CustomContainer(
                              image: lastList[index].image.toString(),
                              title: lastList[index].title.toString(),
                              subTitle: lastList[index].subTitle.toString(),
                              price: lastList[index].price),
                        ),
                      );
                    }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}