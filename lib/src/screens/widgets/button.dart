import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool? isLoading;
  final double? size;

  const CustomButton(
      {Key? key, required this.text, this.onTap, this.isLoading, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading == true ? null : onTap,
      child: Container(
        height: 47,
        width: size ?? 206,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [primaryColor, const Color.fromRGBO(153, 186, 102, 1)]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isLoading == true
              ? const SpinKitCircle(
                  color: Colors.white,
                  size: 35,
                )
              : Text(
                  text,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}
