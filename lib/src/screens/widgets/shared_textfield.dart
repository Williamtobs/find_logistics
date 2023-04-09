import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';

class SharedField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText, enabled, isPassword;
  final String? hint;
  final Function()? onPressed;
  const SharedField(
      {super.key,
      required this.controller,
      this.obscureText,
      this.enabled,
      this.isPassword = false,
      this.onPressed,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(45, 95, 46, 1),
          width: 1,
        ),
      ),
      child: TextField(
        enabled: enabled ?? true,
        controller: controller,
        obscureText: obscureText ?? false,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: isPassword!
              ? InkWell(
                  onTap: onPressed,
                  child: Icon(
                    obscureText ?? false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: primaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
