import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/models/UserModel.dart';
import 'package:yahya_project/provider/user_provider.dart';
import 'package:yahya_project/services/cloudinaryService.dart';
import 'package:yahya_project/services/userService.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';
import 'package:yahya_project/widgets/custom_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  XFile? selectedImage;
  String? currentImageUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    var user = Provider.of<UserProvider>(context, listen: false).getUser();
    nameController = TextEditingController(text: user.userName ?? '');
    emailController = TextEditingController(text: user.userEmail ?? '');
    currentImageUrl = user.userImage;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

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

  Widget _buildAvatarPreview() {
    ImageProvider? imageProvider;
    if (selectedImage != null) {
      imageProvider = kIsWeb
          ? NetworkImage(selectedImage!.path)
          : FileImage(File(selectedImage!.path)) as ImageProvider;
    } else if (currentImageUrl != null && currentImageUrl!.isNotEmpty) {
      if (currentImageUrl!.startsWith('http')) {
        imageProvider = NetworkImage(currentImageUrl!);
      } else {
        imageProvider = AssetImage(currentImageUrl!);
      }
    } else {
      imageProvider = AssetImage(AppAssets.profileImage);
    }

    return CircleAvatar(
      radius: 50,
      backgroundImage: imageProvider,
      child: Align(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var currentUser = userProvider.getUser();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppbar(
          title: "Update Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => _showImagePickerOption(context),
                  child: _buildAvatarPreview(),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Full Name",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyColor,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Email",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyColor,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: CustomButton(
                        buttonLabel: "Update Profile",
                        onPressed: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });

                            String? imageUrl = currentImageUrl;
                            if (selectedImage != null) {
                              final uploadedUrl = await CloudinaryService.uploadImage(selectedImage!);
                              if (uploadedUrl == null) {
                                throw Exception("Failed to upload image to Cloudinary.");
                              }
                              imageUrl = uploadedUrl;
                            }

                            UserModel updatedModel = UserModel(
                              docId: currentUser.docId,
                              userName: nameController.text.trim(),
                              userImage: imageUrl,
                              userEmail: currentUser.userEmail,
                              createdAt: currentUser.createdAt,
                            );

                            await UserService().updateUser(updatedModel);
                            userProvider.setUser(updatedModel);

                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                            });

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Successful"),
                                  content: const Text("Profile Updated Successfully"),
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
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
