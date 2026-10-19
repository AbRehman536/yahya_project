import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yahya_project/models/product_model.dart';
import 'package:yahya_project/services/cloudinaryService.dart';
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

  XFile? selectedImage;
  bool isLoading = false;

  void _showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(source: ImageSource.gallery);
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.image, size: 50, color: Colors.green),
                        SizedBox(height: 8),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(source: ImageSource.camera);
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt, size: 50, color: Colors.green),
                        SizedBox(height: 8),
                        Text("Camera"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppbar(
          title: "Create Product",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showImagePickerOption(context),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: kIsWeb
                              ? Image.network(selectedImage!.path, fit: BoxFit.cover)
                              : Image.file(File(selectedImage!.path), fit: BoxFit.cover),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text("Tap to add product image"),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Enter Product Name",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(
                  hintText: "Enter Product Weight",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                  hintText: "Enter Product Price",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(
                  hintText: "Enter Product Details",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nutritionController,
                decoration: const InputDecoration(
                  hintText: "Enter Product Nutritions",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      buttonLabel: "Create Product",
                      onPressed: () async {
                        try {
                          isLoading = true;
                          setState(() {});

                          String? imageUrl;
                          if (selectedImage != null) {
                            imageUrl = await CloudinaryService.uploadImage(selectedImage!);
                            if (imageUrl == null) {
                              throw Exception("Failed to upload image to Cloudinary.");
                            }
                          }

                          await ProductService().createProduct(
                            ProductModel(
                              productName: nameController.text,
                              productImage: imageUrl,
                              productWeight: weightController.text,
                              productNutrition: int.tryParse(nutritionController.text) ?? 0,
                              productPrice: double.tryParse(priceController.text) ?? 0.0,
                              productDetails: detailsController.text,
                              productStock: true,
                              createdAt: DateTime.now().millisecondsSinceEpoch,
                            ),
                          );

                          if (!mounted) return;
                          isLoading = false;
                          setState(() {});
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Successful"),
                                content: const Text("Product Added Successfully"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Okay"),
                                  )
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          if (!mounted) return;
                          isLoading = false;
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
