import 'package:flutter/material.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/services/productService.dart';
import 'package:yahya_project/widgets/custom_button.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel model;
  const ProductDetailScreen({super.key, required this.model});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isShow = false;
  int quantity = 1;
  late bool isFavorite;
  late bool isBestSelling;
  late bool isExclusiveOffer;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.model.favorite?.contains("101") ?? false;
    isBestSelling = widget.model.bestSelling ?? false;
    isExclusiveOffer = widget.model.exclusiveOffer ?? false;
  }


  void _incrementProduct() {
    setState(() {
      quantity++;
    });
  }

  void _decrementProduct() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  Widget _buildProductImage(String? img) {
    if (img == null || img.isEmpty || img == 'null') {
      return Container(
        width: double.infinity,
        height: 340,
        color: const Color(0xffF2F3F2),
        child: const Icon(Icons.image, size: 100, color: Colors.grey),
      );
    }
    if (img.startsWith('http://') || img.startsWith('https://')) {
      return Image.network(
        img,
        width: double.infinity,
        height: 340,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: double.infinity,
          height: 340,
          color: const Color(0xffF2F3F2),
          child: const Icon(Icons.broken_image, size: 100, color: Colors.grey),
        ),
      );
    }
    return Image.asset(
      img,
      width: double.infinity,
      height: 340,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: double.infinity,
        height: 340,
        color: const Color(0xffF2F3F2),
        child: const Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double price = widget.model.productPrice ?? 0.0;
    final double totalPrice = price * quantity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xffF2F3F2),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _buildProductImage(widget.model.productImage),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          const Icon(Icons.ios_share_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                dense: true,
                title: Text(
                  "${widget.model.productName}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                subtitle: Text(
                  "${widget.model.productWeight}, Price",
                  style: TextStyle(color: AppColors.greyColor),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final String userId = "101";
                    final String? docId = widget.model.docId;
                    if (docId == null || docId.isEmpty) return;

                    final bool previousStatus = isFavorite;
                    setState(() {
                      isFavorite = !isFavorite;
                    });

                    final messenger = ScaffoldMessenger.of(context);
                    try {
                      if (previousStatus) {
                        await ProductService().removeFromFavorite(
                          userID: userId,
                          productID: docId,
                        );
                      } else {
                        await ProductService().addToFavorite(
                          userID: userId,
                          productID: docId,
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        setState(() {
                          isFavorite = previousStatus;
                        });
                        messenger.showSnackBar(
                          SnackBar(content: Text("Error updating favorite: $e")),
                        );
                      }
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _decrementProduct();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 0.3,
                              color: AppColors.greyColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3,
                            ),
                            child: Text(
                              "$quantity",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            _incrementProduct();
                          },
                          icon: Icon(Icons.add, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: const Divider(height: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Product Detail",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      icon: Icon(isShow
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_right_outlined),
                    )
                  ],
                ),
              ),
              if (isShow)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text(
                    "${widget.model.productDetails}",
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: const Divider(height: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nutritions",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.model.productNutrition}g",
                          style: TextStyle(
                            backgroundColor: AppColors.greyColor.withOpacity(0.2),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.keyboard_arrow_right)
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: const Divider(height: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Review",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    Row(
                      children: [
                        Image.asset(AppAssets.notificationIcon, width: 30),
                        const SizedBox(width: 10),
                        const Icon(Icons.keyboard_arrow_right)
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: isBestSelling,
                          onChanged: (val)async{
                            final newValue = val ?? false;
                            setState(() {
                              isBestSelling = newValue;
                            });
                            await ProductService().markBestSellingProduct(
                                widget.model.docId.toString(),
                                newValue);
                          }),
                      const Text("Best Selling"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isExclusiveOffer,
                          onChanged: (val)async{
                            final newValue = val ?? false;
                            setState(() {
                              isExclusiveOffer = newValue;
                            });
                            await ProductService().markExclusiveProduct(
                                widget.model.docId.toString(),
                                newValue);
                          }),
                      const Text("Exclusive Offer"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomButton(buttonLabel: "Add To Basket", onPressed: ()async {
                await ProductService().addToCart(
                    userID: "101",
                    productID: widget.model.docId.toString());
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
