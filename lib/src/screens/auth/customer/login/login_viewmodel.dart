import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/dashboard/dashboard.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this.network) : super(LoginState());

  final Network network;

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
      final response = await network.post(formData: formData, path: 'login');
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        BottomSnack.successSnackBar(message: body['message'], context: context);
        state = state.copyWith(isLoading: false);
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        BottomSnack.errorSnackBar(message: body['message'], context: context);
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      BottomSnack.errorSnackBar(message: e.toString(), context: context);
      state = state.copyWith(isLoading: false);
    }
  }
}

class LoginState {
  final bool isLoading;

  LoginState({this.isLoading = false});

  LoginState copyWith({bool? isLoading}) {
    return LoginState(isLoading: isLoading ?? this.isLoading);
  }
}
