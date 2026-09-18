import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  final String title;
  const CustomListTile({super.key, required this.leading, required this.trailing, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //dense: true,
      contentPadding: .zero,
      horizontalTitleGap: 5,
      leading: leading,
      title: Text(title,style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xff272727)
      ),),
      //subtitle: Text("Subtitle"),
      trailing: trailing,
    );
  }
}
