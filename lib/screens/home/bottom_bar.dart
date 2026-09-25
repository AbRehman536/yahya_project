import 'package:flutter/material.dart';
import 'package:yahya_project/screens/home/explore.dart';
import 'package:yahya_project/screens/home/favorite.dart';
import 'package:yahya_project/screens/home/home_screen.dart';
import 'package:yahya_project/screens/home/my_cart.dart';
import 'package:yahya_project/screens/profile/profile_screen.dart';
import 'package:yahya_project/utils/app_colors.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Widget> screenList = [
    HomeScreen(),
    ExploreScreen(),
    MyCartScreen(),
    FavoriteScreen(),
    ProfileScreen()
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
        },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Shop"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          ]),
    );
  }
}
