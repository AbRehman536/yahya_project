import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/services/productService.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';

import '../../models/favorite_model.dart';
import '../../utils/app_assets.dart';
import '../../widgets/custom_button.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: "My Cart",
        ),
      ),
      body:
      StreamProvider.value(
          value: ProductService().getMyCartProducts("101"),
          initialData: [ProductModel()],
          builder: (context, child){
            List<ProductModel> favoriteList = context.watch<List<ProductModel>>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(favoriteList[index].productImage.toString()),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(favoriteList[index].productName.toString()),
                              Text(favoriteList[index].productWeight.toString())
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: .circular(5),
                                      border: Border.all(
                                          color: AppColors.greyColor,
                                          width: 0.3
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.remove),
                                  )),
                              SizedBox(width: 5,),
                              Text("1"),
                              SizedBox(width: 5,),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: .circular(5),
                                      border: Border.all(
                                          color: AppColors.greyColor,
                                          width: 0.3
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(Icons.add),
                                  ))
                            ],
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: ()async{
                                    await ProductService().removeFromCart(
                                        userID: "101",
                                        productID: favoriteList[index].docId.toString());
                                  } ,
                                  child: Icon(Icons.close)),
                              SizedBox(height: 15,),
                              Text("\$${favoriteList[index].productPrice.toString()}")
                            ],
                          ),
                        );
                      },),
                  ),
                  CustomButton(buttonLabel: "Go to Check out", onPressed: (){
                    showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text("Checkout"),
                                  IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, icon:  Icon(Icons.close))

                                ],
                              ),
                              ListTile(
                                title: Text("Delivery"),
                                trailing: Row(
                                  mainAxisSize: .min,
                                  children: [
                                    Text("Select Method"),
                                    Icon(Icons.arrow_forward_ios_sharp)
                                  ],
                                ),
                              ),
                              Divider(height: 0.5,color: AppColors.greyColor,),
                              ListTile(
                                title: Text("Payment"),
                                trailing: Row(
                                  mainAxisSize: .min,
                                  children: [
                                    Text("Select Method"),
                                    Icon(Icons.arrow_forward_ios_sharp)
                                  ],
                                ),
                              ),
                              Divider(height: 0.5,color: AppColors.greyColor,),
                              ListTile(
                                title: Text("Promo Code"),
                                trailing: Row(
                                  mainAxisSize: .min,
                                  children: [
                                    Text("Pick discount"),
                                    Icon(Icons.arrow_forward_ios_sharp)
                                  ],
                                ),
                              ),
                              Divider(height: 0.5,color: AppColors.greyColor,),
                              ListTile(
                                title: Text("Total Cost"),
                                trailing: Row(
                                  mainAxisSize: .min,
                                  children: [
                                    Text("\$13.97"),
                                    Icon(Icons.arrow_forward_ios_sharp)
                                  ],
                                ),
                              ),
                              Divider(height: 0.5,color: AppColors.greyColor,),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "By placing an order to agree to our ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.greyColor
                                        )
                                    ),
                                    TextSpan(
                                        text: "Terms",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkColor
                                        )
                                    ),
                                    TextSpan(
                                        text: "And",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.greyColor
                                        )
                                    ),
                                    TextSpan(
                                        text: "Conditions",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkColor
                                        )
                                    ),
                                  ],

                                ),
                              ),
                              CustomButton(
                                  buttonLabel: "Place Order",
                                  onPressed: (){
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return
                                          Dialog(
                                            child: SizedBox(
                                              height: 600,
                                              width: 364,
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                        },
                                                        child: Icon(Icons.close)),
                                                    Image.asset(AppAssets.dialogImage,width: 222,height: 222,),
                                                    Text("Oops, Order Failed"),
                                                    Text("Something went wrong"),
                                                    CustomButton(buttonLabel: "Please Try Again", onPressed: (){}),
                                                    TextButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    }, child: Text("Back to home"))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        //   AlertDialog(
                                        //   title: Text("Thank You!"),
                                        //   content: Text("Order Failed"),
                                        //   actions: [
                                        //     TextButton(onPressed: (){}, child: Text("Try Again")),
                                        //     TextButton(onPressed: (){}, child: Text("Back to Home")),
                                        //   ],
                                        // );
                                      },
                                    );
                                  })
                            ],
                          ),
                        );
                      }, );
                  })
                ],
              ),
            );
          },
      )

    );
  }
}
