import 'package:flutter/material.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';

class BeveragesScreen extends StatefulWidget {
  const BeveragesScreen({super.key});

  @override
  State<BeveragesScreen> createState() => _BeveragesScreenState();
}

class _BeveragesScreenState extends State<BeveragesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          leading: Icon(Icons.arrow_back_ios_new),
          title: "Beverages",
          icon: Icon(Icons.filter_list_sharp),
        ),
      ),
    );
  }
}
