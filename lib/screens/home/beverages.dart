import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/models/categoryModel.dart';
import 'package:yahya_project/screens/home/product_details.dart';
import 'package:yahya_project/services/productService.dart';
import '../../Widgets/custom_appbar.dart';
import '../../models/product_model.dart';
import '../../utils/app_assets.dart';
import '../../widgets/custom_grid.dart';

class BeveragesScreen extends StatefulWidget {
  final CategoryModel model;
  const BeveragesScreen({super.key, required this.model});

  @override
  State<BeveragesScreen> createState() => _BeveragesScreenState();
}

class _BeveragesScreenState extends State<BeveragesScreen> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomAppbar(
              title: "${widget.model.categoryName}",
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              icon: Image.asset(AppAssets.notificationIcon,width: 16,height: 17,),
            ),
          )),
      body:  StreamProvider<List<ProductModel>>.value(
        value: ProductService().getProductsByCategoryID(widget.model.docId.toString()),
        initialData: [],
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
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailScreen(model: productList[index],)));
                          },
                          product: productList[index],
                          productID: productList[index].docId.toString(),
                          image: (productList[index].productImage != null && productList[index].productImage!.isNotEmpty)
                              ? productList[index].productImage!
                              : exclusiveList[index % exclusiveList.length].image.toString(),
                          title: productList[index].productName.toString(),
                          subTitle: productList[index].productWeight.toString(),
                          price: double.tryParse(productList[index].productPrice.toString()) ?? 0.0),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}