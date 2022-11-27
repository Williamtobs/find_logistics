import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class BottomSnack {
  static void successSnackBar(
      {required String message, required BuildContext context}) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.success,
      duration: const Duration(seconds: 4),
    ).show(context);
  }

  static void errorSnackBar(
      {required String message, required BuildContext context}) {
    AnimatedSnackBar.material(
      message,
      type: AnimatedSnackBarType.error,
      duration: const Duration(seconds: 4),
    ).show(context);
  }
}
