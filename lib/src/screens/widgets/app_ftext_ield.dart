import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final bool? isVisible;
  final TextEditingController? controller;
  final Color? color;
  final TextInputType? keyboardType;
  const AppTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.isVisible,
      this.keyboardType,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: color != null ? Border.all(color: color!) : null,
      ),
      child: Center(
        child: TextFormField(
          obscureText: isVisible ?? false,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            //filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),

            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
