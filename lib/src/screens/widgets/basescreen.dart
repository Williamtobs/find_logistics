import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  const BaseScreen({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
      body: child,
    );
  }
}
