import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yahya_project/provider/theme_provider.dart';
import 'package:yahya_project/provider/user_provider.dart';
import 'package:yahya_project/screens/profile/update_profile.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_listTile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var user = userProvider.getUser();
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 30,
                backgroundImage: user.userImage != null && user.userImage!.startsWith('http')
                    ? NetworkImage(user.userImage!) as ImageProvider
                    : AssetImage(AppAssets.profileImage),
              ),
              const SizedBox(height: 10),
              Text(
                "${user.userName}",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                "${user.userEmail}",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey[400] : const Color(0xff848484),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 150,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateProfileScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.edit),
                      Text("Edit Profile"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon, width: 18, height: 20),
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 15),
                title: "Notifications",
              ),
              Divider(
                height: 0.6,
                color: isDark ? Colors.grey[800] : const Color(0xffA2A2A2),
              ),
              CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon, width: 18, height: 20),
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 15),
                title: "Privacy Policy",
              ),
              Divider(
                height: 0.6,
                color: isDark ? Colors.grey[800] : const Color(0xffA2A2A2),
              ),
              CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon, width: 18, height: 20),
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 15),
                title: "Term & Conditions",
              ),
              Divider(
                height: 0.6,
                color: isDark ? Colors.grey[800] : const Color(0xffA2A2A2),
              ),
              CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon, width: 18, height: 20),
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 15),
                title: "Help & Support",
              ),
              Divider(
                height: 0.6,
                color: isDark ? Colors.grey[800] : const Color(0xffA2A2A2),
              ),
              CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon, width: 18, height: 20),
                trailing: const Icon(Icons.arrow_forward_ios_sharp, size: 15),
                title: "Invite Your Friend",
              ),
              Divider(
                height: 0.6,
                color: isDark ? Colors.grey[800] : const Color(0xffA2A2A2),
              ),
              CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon, width: 18, height: 20),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  activeTrackColor: AppColors.primaryColor,
                  onChanged: (bool value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
                title: "Dark Mode",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
