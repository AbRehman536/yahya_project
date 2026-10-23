import 'package:flutter/material.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/screens/admin/update_product.dart';
import 'package:yahya_project/services/productService.dart';
import '../utils/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final double price;

  final String? productID;
  final ProductModel? product;
  final VoidCallback? onEdit;
  final VoidCallback? onTap;
  final VoidCallback? addCart;
  final bool? stock;

  const CustomContainer({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.price,
    this.productID,
    this.product,
    this.onEdit, this.onTap, this.stock, this.addCart,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
     onTap: onTap,
      child: Container(
        width: 173,
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 0.4, color: AppColors.greyColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: image.startsWith('http')
                    ? Image.network(
                  image,
                  width: 89,
                  height: 79,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, size: 50),
                )
                    : Image.asset(
                  image,
                  width: 89,
                  height: 79,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image, size: 50),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              Text(
                "$subTitle, Price ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$$price",
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  FloatingActionButton.small(
                    onPressed: addCart,
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (product != null)
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProduct(product: product!),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    )
                  else if (onEdit != null)
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    )
                  else
                    const SizedBox.shrink(),
                  if (productID != null)
                    IconButton(
                      onPressed: () async {
                        try {
                          await ProductService().deleteProduct(productID!);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    )
                  else
                    const SizedBox.shrink(),
                  Checkbox(
                      value: product?.productStock,
                      onChanged: (val)async{
                        await ProductService().markStockProduct(
                            productID!,
                            val!);
                      })
                ],
              ),
              if(stock == false)
                Text("Out of Stock")
            ],
          ),
        ),
      ),
    );
  }
}
