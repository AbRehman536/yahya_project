import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  final String title;
  const CustomListTile({super.key, required this.leading, required this.trailing, required this.title});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 5,
      leading: leading,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white70 : const Color(0xff272727),
        ),
      ),
      trailing: trailing,
    );
  }
}
