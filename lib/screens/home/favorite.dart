import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/screens/home/product_details.dart';
import 'package:yahya_project/services/productService.dart';
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: "Favorite",
        ),
      ),
      body: StreamProvider<List<ProductModel>>.value(
        value: ProductService().getFavoriteProducts("101"),
        initialData: const [],
        builder: (context, child) {
          List<ProductModel> favoriteList = context.watch<List<ProductModel>>();

          if (favoriteList.isEmpty) {
            return const Center(
              child: Text(
                "No Favorite Products",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = favoriteList[index];
                      final String img = product.productImage ?? '';

                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(model: product),
                            ),
                          );
                        },
                        leading: (img.startsWith('http://') || img.startsWith('https://'))
                            ? Image.network(
                                img,
                                width: 40,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported, size: 40),
                              )
                            : (img.isNotEmpty
                                ? Image.asset(
                                    img,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.image, size: 40),
                                  )
                                : const Icon(Icons.image, size: 40)),
                        title: Text(product.productName ?? 'Unnamed Product'),
                        subtitle: Text(product.productWeight ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "\$${(product.productPrice ?? 0.0).toStringAsFixed(2)}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.red),
                              onPressed: () async {
                                final docId = product.docId;
                                if (docId != null && docId.isNotEmpty) {
                                  await ProductService().removeFromFavorite(
                                    userID: "101",
                                    productID: docId,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                  buttonLabel: "Add All To Cart",
                  onPressed: () async {
                    for (var product in favoriteList) {
                      final docId = product.docId;
                      if (docId != null && docId.isNotEmpty) {
                        await ProductService().addToCart(
                          userID: "101",
                          productID: docId,
                        );
                      }
                    }
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("All favorite products added to cart!")),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
