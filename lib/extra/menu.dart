import 'package:flutter/material.dart';
import 'package:yahya_project/screens/home/beverages.dart';
import 'package:yahya_project/screens/home/favorite.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Screen"),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> FavoriteScreen()));
                      },
                      leading: Icon(Icons.new_label),
                      title: Text("New Tab"),
                      trailing: Text("Ctrl + T"),
                    )),
                PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.tab),
                      title: Text("New Window"),
                      trailing: Text("Ctrl + W"),
                    )),
                PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text("History"),
                      trailing: Text("Ctrl + H"),
                    )),
                PopupMenuItem(
                    child: ListTile(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                      trailing: Text("ESC"),
                    )),
              ];
            },)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: AppColors.primaryColor,
              height: 130,
              child: DrawerHeader(child: Column(children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppAssets.profileImage),
                ),
                Text("Morgan Mills")
              ],)),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FavoriteScreen()));
              },
              leading: Icon(Icons.home_filled),
              title: Text("Home"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FavoriteScreen()));
              },
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
