import 'package:flutter/material.dart';
import 'package:yahya_project/models/favorite_model.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';
import 'package:yahya_project/widgets/custom_button.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<FavoriteModel> favoriteList = [
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Sprite Can",
        description: "325ml",
        price: 1.50),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Diet Coke",
        description: "355ml",
        price: 1.99),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Apple Juice",
        description: "2L",
        price: 15.50),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Coca Cola Can",
        description: "325ml",
        price: 1.55),
    FavoriteModel(
        image: AppAssets.can1Image,
        title: "Pepsi Can",
        description: "330ml",
        price: 4.50),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: "Favorite",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: favoriteList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.asset(favoriteList[index].image.toString()),
                    title: Text(favoriteList[index].title.toString()),
                    subtitle: Text(favoriteList[index].description.toString()),
                    trailing: Row(
                      mainAxisSize: .min,
                      children: [
                        Text("\$${favoriteList[index].price.toString()}"),
                        Icon(Icons.arrow_forward_ios_sharp)
                      ],
                    ),
                  );
                },),
            ),
            CustomButton(buttonLabel: "Add All To Cart", onPressed: (){})
          ],
        ),
      ),
    );
  }
}
