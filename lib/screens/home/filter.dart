import 'package:flutter/material.dart';
import 'package:yahya_project/widgets/custom_appbar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: "Filters",
          leading: Icon(Icons.close),
        ),
      ),
    );
  }
}
