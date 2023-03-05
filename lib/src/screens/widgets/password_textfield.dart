import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextfield extends StatelessWidget {
  final String hintText;
  final String? hint2;
  final TextEditingController controller;
  final bool? obscureText, enabled;
  final Function()? onPressed;
  final String? Function(String?)? validator;
  const PasswordTextfield(
      {super.key,
      required this.hintText,
      this.hint2,
      required this.controller,
      this.obscureText,
      this.enabled,
      this.onPressed,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: 90,
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
            height: 3,
          ),
          Text(
            hintText,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          TextFormField(
            enabled: enabled ?? true,
            controller: controller,
            obscureText: obscureText ?? false,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: primaryColor,
            ),
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none, hintText: hint2,
              suffixIcon: InkWell(
                onTap: onPressed,
                child: Icon(
                  obscureText ?? false
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: primaryColor,
                ),
              ),

              // IconButton(
              //     icon: Icon(
              //       obscureText ?? false
              //           ? Icons.visibility
              //           : Icons.visibility_off,
              //       color: primaryColor,
              //     ),
              //     ),
              //contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          )
        ],
      ),
    );
  }
}
