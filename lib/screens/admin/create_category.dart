import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Services/cloudinaryService.dart';
import '../../models/categoryModel.dart';
import '../../services/categoryService.dart';
import '../../widgets/custom_button.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  XFile? selectedImage;
  void _showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.image, size: 50),
                        SizedBox(height: 5),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      final img = await CloudinaryService.pickImage(
                        source: ImageSource.camera,
                      );
                      if (img != null) {
                        setState(() {
                          selectedImage = img;
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.camera_alt, size: 50),
                        SizedBox(height: 5),
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
      appBar: AppBar(title: Text("Add Category"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showImagePickerOption(context),
              child: Container(
                alignment: .center,
                width: .infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: .all(color: Colors.grey, width: 1),
                ),
                child: selectedImage != null
                    ? ClipRRect(
                  borderRadius: .circular(20),
                  child: kIsWeb
                      ? Image.network(selectedImage!.path, fit: .cover)
                      : Image.file(
                    File(selectedImage!.path),
                    fit: .cover,
                  ),
                )
                    : Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.add_a_photo, size: 50),
                    SizedBox(height: 10),
                    Text("Tap to Add Image"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Enter Category name"),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : CustomButton(buttonLabel:  "add Category", onPressed:() async {
              try {
                setState(() {
                  isLoading = true;
                });
                String? imageURL;
                if (selectedImage != null) {
                  imageURL = await CloudinaryService.uploadImage(
                    selectedImage!,
                  );
                  if (imageURL == null) {
                    throw Exception(
                      "Failed to upload image to Cloudinary",
                    );
                  }
                }
                await CategoryService()
                    .createCategory(
                  CategoryModel(
                    categoryName: nameController.text,
                    categoryImage: imageURL,
                    createdAt: DateTime.now().millisecondsSinceEpoch,
                    stock: true,
                  ),
                )
                    .then((value) {
                  setState(() {
                    isLoading = false;
                    if (!mounted) return;
                  });
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Added Successfully"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text("Back to Home"),
                          ),
                        ],
                      );
                    },
                  );
                });
              } catch (e) {
                setState(() {
                  isLoading = false;
                  if (!mounted) return;
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }),
          ],
        ),
      ),
    );
  }
}