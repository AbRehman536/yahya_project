import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final Widget? icon;
  const CustomAppbar({super.key, this.title, this.leading, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffFFFFFF),
      elevation: 0,
      leading: leading,
      title: Text(title.toString(),style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: Color(0xff181725)
      ),),
      centerTitle: true,
      actions: [
        ?icon
      ],
    );
  }
}
