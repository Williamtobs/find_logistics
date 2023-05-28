import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/auth/forgot_password/reset_password.dart';
import 'package:find_logistic/src/screens/auth/forgot_password/verify_otp.dart';
import 'package:find_logistic/src/screens/onboarding/mode_selection.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel(this.network) : super(ForgotPasswordState());

  final Network network;

  forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    state = state.copyWith(isLoading: true);
    var formData = {
      'email': email,
    };
    try {
      final response =
          await network.post(formData: formData, path: 'send/password/token');
      var body = response.data;
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        BottomSnack.successSnackBar(message: body['message'], context: context);
        if (!mounted) return;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VerifyOtp()));
      } else {
        state = state.copyWith(isLoading: false);
        BottomSnack.errorSnackBar(message: body['message'], context: context);
      }
    } catch (e) {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
      state = state.copyWith(isLoading: false);
    }
  }

  verifyOtp({
    required BuildContext context,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true);
    var formData = {
      'password_reset_token': otp,
    };
    try {
      final response =
          await network.post(formData: formData, path: 'password/token');
      var body = response.data;
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        BottomSnack.successSnackBar(message: body['message'], context: context);
        if (!mounted) return;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword()));
      } else {
        state = state.copyWith(isLoading: false);
        BottomSnack.errorSnackBar(message: body['message'], context: context);
      }
    } catch (e) {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
      state = state.copyWith(isLoading: false);
    }
  }

  resetPassword({
    required BuildContext context,
    required String password,
    required String confirmPassword,
  }) async {
    state = state.copyWith(isLoading: true);
    var formData = {
      'password': password,
      'confirm_password': confirmPassword,
    };
    try {
      final response = await network.postWithToken(
          formData: formData, path: 'reset/password');
      var body = response.data;
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        BottomSnack.successSnackBar(message: body['message'], context: context);
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UserSelectMode()),
            (route) => false);
      } else {
        state = state.copyWith(isLoading: false);
        BottomSnack.errorSnackBar(message: body['message'], context: context);
      }
    } catch (e) {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
      state = state.copyWith(isLoading: false);
    }
  }
}

class ForgotPasswordState {
  final bool isLoading;

  ForgotPasswordState({
    this.isLoading = false,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
