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
            CustomButton(
                buttonLabel: "Create Product",
                onPressed: ()async{
                  try{
                    await ProductService().createProduct(
                      ProductModel(
                        productName: nameController.text,
                        productWeight: int.parse(weightController.text),
                        productNutrition: int.parse(nutritionController.text),
                        productPrice: int.parse(priceController.text),
                        productDetails: detailsController.text,
                        productStock: true,
                        createdAt: DateTime.now().millisecondsSinceEpoch
                      )
                    );
                  }catch(e){
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
