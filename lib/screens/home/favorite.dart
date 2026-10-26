import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/models/favorite_model.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/services/productService.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';
import 'package:yahya_project/widgets/custom_button.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: "Favorite",
        ),
      ),
      body:
      StreamProvider.value(
          value: ProductService().getFavoriteProducts("101"),
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
                          leading: favoriteList[index].productImage!.startsWith('http')
                              ? Image.network(
                            favoriteList[index].productImage.toString(),
                            width: 40,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 50),
                          )
                              : Image.asset(
                            favoriteList[index].productImage.toString(),
                            width: 40,
                            height: 40,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image, size: 50),
                          ),
                          title: Text(favoriteList[index].productName.toString()),
                          subtitle: Text(favoriteList[index].productWeight.toString()),
                          trailing: Row(
                            mainAxisSize: .min,
                            children: [
                              Text("\$${favoriteList[index].productPrice.toString()}"),
                              Icon(Icons.arrow_forward_ios_sharp)
                            ],
                          ),
                        );
                      },),
                  ),
                  CustomButton(buttonLabel: "Add All To Cart", onPressed: (){})
                ],
              ),
            );
        },
      )

    );
  }
}
