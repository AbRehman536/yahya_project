import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_listTile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 90,),
            CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(AppAssets.profileImage),),
            Text("Morgan Mill",style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black
            ),),
            Text("morganmill@gmail.com",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff848484)
            ),),
            SizedBox(height: 15,),
            SizedBox(
              width: 150,
              height: 52,
              child: ElevatedButton(onPressed: (){}
                  , child: Row(
                  mainAxisAlignment: .spaceAround,
                    children: [
                      Icon(Icons.edit),
                     // SizedBox(width: 5,),
                      Text("Edit Profile")
                    ],
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(16)
                    )
                ),
              ),
            ),
            SizedBox(height: 15,),
            CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon,width: 18,height: 20,),
                trailing: Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                title: "Notifications"),
            Divider(
              height: 0.6,
              color: Color(0xffA2A2A2),
            ),
            CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon,width: 18,height: 20,),
                trailing: Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                title: "Privacy Policy"),
            Divider(
              height: 0.6,
              color: Color(0xffA2A2A2),
            ),
            CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon,width: 18,height: 20,),
                trailing: Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                title: "Term & Conditions"),
            Divider(
              height: 0.6,
              color: Color(0xffA2A2A2),
            ),
            CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon,width: 18,height: 20,),
                trailing: Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                title: "Help & Support"),
            Divider(
              height: 0.6,
              color: Color(0xffA2A2A2),
            ),
            CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon,width: 18,height: 20,),
                trailing: Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                title: "Invite Your Friend"),
            Divider(
              height: 0.6,
              color: Color(0xffA2A2A2),
            ),
            CustomListTile(
                leading: Image.asset(AppAssets.notificationIcon,width: 18,height: 20,),
                trailing: Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                title: "Dark Mode"),
          ],
        ),
      ),
    );
  }
}
