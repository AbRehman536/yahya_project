import 'package:flutter/material.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/services/productService.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';
import 'package:yahya_project/widgets/custom_button.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController nutritionController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
            title: "Create Product",
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hint: Text("Enter Product Name")
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                hint: Text("Enter Product Weight")
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                hint: Text("Enter Product Price")
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: detailsController,
              decoration: InputDecoration(
                hint: Text("Enter Product Details")
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: nutritionController,
              decoration: InputDecoration(
                hint: Text("Enter Product Nutritions")
              ),
            ),
            SizedBox(height: 10,),
            isLoading ? Center(child: CircularProgressIndicator(),)
            :CustomButton(
                buttonLabel: "Create Product",
                onPressed: ()async{
                  try{
                    isLoading = true;
                    setState(() {});
                    await ProductService().createProduct(
                      ProductModel(
                        productName: nameController.text,
                        productWeight: weightController.text,
                        productNutrition: int.parse(nutritionController.text),
                        productPrice: double.parse(priceController.text),
                        productDetails: detailsController.text,
                        productStock: true,
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                    ).then((value){
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Successful"),
                          content: Text("Product Add Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                      },);
                    });
                  }catch(e){
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                })

          ],
        ),
      ),
    );
  }
}
