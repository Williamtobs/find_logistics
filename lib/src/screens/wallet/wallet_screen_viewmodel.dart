import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:find_logistic/src/app/constant/app_string.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

class WalletViewModel extends StateNotifier<WalletState> {
  WalletViewModel(this.network) : super(WalletState());

  final Network network;

  initiateTransaction({required BuildContext context, var formData}) async {
    try {
      final response = await network.postWithToken(
          formData: formData, path: 'update/profile');
      var body = response.data;
      if (response.statusCode == 200) {
        BottomSnack.successSnackBar(message: body['message'], context: context);
        
      } else {
        BottomSnack.errorSnackBar(message: body['message'], context: context);
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
    }
  }

  Future<String> createAccessCode(
    getReference,
    int amount,
    String email,
  ) async {
    // skTest -> Secret key
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $paystackPubKey'
    };
    Map data = {"amount": amount, "email": email, "reference": getReference};
    String payload = json.encode(data);
    http.Response response = await http.post(
        Uri.parse('https://api.paystack.co/transaction/initialize'),
        headers: headers,
        body: payload);
    final Map datas = jsonDecode(response.body);
    String accessCode = datas['data']['access_code'];
    return accessCode;
  }

  void verifyOnServer(String reference) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $paystackPubKey'
      };
      http.Response response = await http.get(
          Uri.parse('https://api.paystack.co/transaction/verify/$reference'),
          headers: headers);
      final Map body = json.decode(response.body);
      if (body['data']['status'] == 'success') {
        //do something with the response. show success}

      } else {
        //show error prompt}
      }
    } catch (e) {
      print(e);
    }
  }

  // void updateWallet(Wallet wallet) {
  //   state = state.copyWith(wallet: wallet);
  // }
}

class WalletState {
  final bool isLoading;

  WalletState({this.isLoading = false});

  WalletState copyWith({bool? isLoading}) {
    return WalletState(isLoading: isLoading ?? this.isLoading);
  }
}
