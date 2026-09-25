import 'package:flutter/material.dart';
import 'package:yahya_project/utils/app_assets.dart';
import 'package:yahya_project/utils/app_colors.dart';
import 'package:yahya_project/widgets/custom_field.dart';
import 'package:yahya_project/widgets/custom_listTile.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Tab Bar"),
          leading: Icon(Icons.arrow_back_ios_new),
          actions: [
            Icon(Icons.notification_add),
            Icon(Icons.settings),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              color: AppColors.secondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  tabAlignment: .start,
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorSize: .tab,
                    indicator: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: .circular(12)
                    ),
                    labelColor: AppColors.secondaryColor,
                    unselectedLabelColor: AppColors.primaryColor,
                    tabs: [
                      Tab(text: "All",icon: Icon(Icons.all_inbox),),
                      Tab(text: "Unread",icon: Icon(Icons.mark_as_unread),),
                      Tab(text: "Groups",icon: Icon(Icons.groups),),
                      Tab(text: "Favorite",icon: Icon(Icons.favorite),),
                      Tab(text: "All",icon: Icon(Icons.all_inbox),),
                      Tab(text: "Unread",icon: Icon(Icons.mark_as_unread),),
                      Tab(text: "Groups",icon: Icon(Icons.groups),),
                      Tab(text: "Favorite",icon: Icon(Icons.favorite),),
                    ]),
              ),
            ),
          ),
        ),
        body: TabBarView(
            children: [
              Center(child: Column(
                children: [
                 CustomListTile(
                     leading: Icon(Icons.person),
                     trailing: Icon(Icons.arrow_forward_ios_sharp),
                     title: "Yahya"),
                 CustomListTile(
                     leading: Icon(Icons.person),
                     trailing: Icon(Icons.arrow_forward_ios_sharp),
                     title: "Yahya"),
                 CustomListTile(
                     leading: Icon(Icons.person),
                     trailing: Icon(Icons.arrow_forward_ios_sharp),
                     title: "Yahya"),
      
                ],
              ),),
              Center(
                child: Image.asset(AppAssets.onBoarding),
              ),
              Center(
                child: CustomField(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                ),
              ),
              Center(
                child:  CustomListTile(
                    leading: Icon(Icons.all_inbox),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                    title: "Ahmed"),
              ),
            ]),
      ),
    );
  }
}
