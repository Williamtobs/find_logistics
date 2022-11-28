import 'package:find_logistic/src/app/model/auth_model.dart';
import 'package:find_logistic/src/app/model/user.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/auth/customer/register/verify_email.dart';
import 'package:find_logistic/src/screens/dashboard/dashboard.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupViewModel extends StateNotifier<SignupState> {
  SignupViewModel(this.network)
      : super(SignupState(user: AuthModel(), appUser: AppUser()));

  final Network network;

  register({required BuildContext context, required var formData}) async {
    state = state.copyWith(isLoading: true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await network.post(formData: formData, path: 'register');
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        prefs.setString('token', body['data']['token']['accessToken']);
        BottomSnack.successSnackBar(message: body['message'], context: context);
        state = state.copyWith(
          isLoading: false,
          user: AuthModel.fromJson(body['data']['user']),
        );
        if (!mounted) return;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VerifyEmail()));
      } else {
        BottomSnack.errorSnackBar(message: body['message'], context: context);
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
      state = state.copyWith(isLoading: false);
    }
  }

  getProfile({required BuildContext context}) async {
    try {
      var res = await network.get(path: 'profile');
      var body = res.data;
      print(body);
      if (res.statusCode == 200) {
        state = state.copyWith(
          isLoading: false,
          appUser: AppUser.fromJson(body['data']['user']),
        );
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
    }
  }

  verifyEmail({
    required BuildContext context,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true);
    var formData = {
      'otp': otp,
    };
    try {
      final response =
          await network.postWithToken(formData: formData, path: 'verify/email');
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        //state = state.copyWith(isLoading: false);
        BottomSnack.successSnackBar(message: body['message'], context: context);
        getProfile(context: context);
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

  resendOtp({required BuildContext context}) async {
    state = state.copyWith(isLoading: true);
    //var formData = {};
    try {
      final response =
          await network.postWithToken(path: 'resend/otp', formData: {});
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        BottomSnack.successSnackBar(message: body['message'], context: context);
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

class SignupState {
  final bool isLoading;
  final AuthModel user;
  final AppUser appUser;

  SignupState(
      {this.isLoading = false, required this.user, required this.appUser});

  SignupState copyWith({bool? isLoading, AuthModel? user, AppUser? appUser}) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      appUser: appUser ?? this.appUser,
    );
  }
}
