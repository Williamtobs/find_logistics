import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final bool? isLoading;
  final void Function()? onPressed;
  const AppButton(
      {Key? key,
      required this.text,
      this.onPressed,
      required this.color,
      this.textColor,
      this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primaryColor,
            )),
        child: Center(
          child: isLoading == true
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: GoogleFonts.inter(
                      color: textColor ?? Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
