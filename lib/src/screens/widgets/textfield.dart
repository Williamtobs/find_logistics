import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInputField extends StatelessWidget {
  final String hintText;
  final String? hint2;
  final TextEditingController controller;
  final bool? obscureText, enabled;
  const AppInputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.enabled,
      this.obscureText,
      this.hint2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            hintText,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          TextField(
            enabled: enabled ?? true,
            controller: controller,
            obscureText: obscureText ?? false,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: primaryColor,
            ),
            decoration: InputDecoration(
                border: InputBorder.none, isDense: true, hintText: hint2
                //contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
          )
        ],
      ),
    );
  }
}
