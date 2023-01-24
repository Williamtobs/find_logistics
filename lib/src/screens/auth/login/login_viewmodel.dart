import 'package:find_logistic/src/app/model/user.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/auth/customer/register/verify_email.dart';
import 'package:find_logistic/src/screens/home/home.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this.network) : super(LoginState(user: AppUser()));

  final Network network;

  getProfile({required BuildContext context}) async {
    try {
      var res = await network.get(path: 'profile');
      var body = res.data;
      print(body);
      if (res.statusCode == 200) {
        if (body['data']['user']['email_verified_at'] == null) {
          BottomSnack.errorSnackBar(
              message: 'Please verify your email first', context: context);
          if (!mounted) return;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VerifyEmail()));
        } else {
          state = state.copyWith(
            isLoading: false,
            user: AppUser.fromJson(body['data']['user']),
          );
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false);
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
    }
  }

  login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    var formData = {
      'email': email,
      'password': password,
    };
    state = state.copyWith(isLoading: true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await network.post(formData: formData, path: 'signin');
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        prefs.setString('token', body['data']['token']['accessToken']);
        BottomSnack.successSnackBar(message: body['message'], context: context);
        getProfile(context: context);
        // state = state.copyWith(
        //   isLoading: false,
        //   user: AppUser.fromJson(body['data']['user']),
        // );

      } else {
        BottomSnack.errorSnackBar(message: body['message'], context: context);
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print(e);
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
      state = state.copyWith(isLoading: false);
    }
  }
}

class LoginState {
  final bool isLoading;
  final AppUser user;

  LoginState({this.isLoading = false, required this.user});

  LoginState copyWith({bool? isLoading, AppUser? user}) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading, user: user ?? this.user);
  }
}
