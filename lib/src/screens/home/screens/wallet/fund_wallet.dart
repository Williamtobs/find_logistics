import 'dart:io';

import 'package:find_logistic/src/app/constant/app_string.dart';
import 'package:find_logistic/src/screens/home/screens/wallet/webview.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

import '../../../widgets/wallet_input_field.dart';

class FundWalletScreen extends ConsumerStatefulWidget {
  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends ConsumerState<FundWalletScreen> {
  bool isSwitched = false;
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  _payWithCard() async {
    PayWithPayStack().now(
        context: context,
        secretKey: paystackPubKey,
        customerEmail: ref.read(dashboardProvider).user.email!,
        reference: _getReference(),
        currency: 'NGN',
        amount: '${_amountController.text}00',
        paymentChannel: ["card", "bank"],
        metaData: {
          "custom_fields": [
            {
              "name": ref.read(dashboardProvider).user.firstName!,
              "phone": ref.read(dashboardProvider).user.phoneNumber
            }
          ]
        },
        transactionCompleted: () {
          print("Transaction Successful");
          initiateTransaction(
            context: context,
          );
          //ref.read(walletProvider.notifier).verifyOnServer(_getReference());
        },
        transactionNotCompleted: () {
          print("Transaction Not Successful!");
          initiateTransaction(
            context: context,
          );
        });
  }

  // initiateTransaction(
  //     {required BuildContext context, required int status}) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String email = ref.read(dashboardProvider).user.email!;
  //   var formData = {
  //     "amount": _amountController.text,
  //     "reference": _getReference(),
  //     'email': email,
  //     'status': status
  //   };
  //   try {
  //     final response = await ref
  //         .read(networkProvider)
  //         .postWithToken(formData: formData, path: 'initiate/topup');
  //     var body = response.data;
  //     print(body);
  //     if (response.statusCode == 200) {
  //       BottomSnack.successSnackBar(message: body['message'], context: context);
  //       _payWithCard();
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     } else {
  //       BottomSnack.errorSnackBar(message: body['message'], context: context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     BottomSnack.errorSnackBar(
  //         message: 'Something went wrong, please try again later',
  //         context: context);
  //   }
  // }

  initiateTransaction({required BuildContext context}) async {
    setState(() {
      _isLoading = true;
    });
    String email = ref.read(dashboardProvider).user.email!;
    var formData = {
      "amount": _amountController.text,
      'email': email,
    };
    try {
      final response = await ref
          .read(networkProvider)
          .postWithToken(formData: formData, path: 'paystack');
      var body = response.data;
      print((body['data']['reference']));
      if (response.statusCode == 200) {
        //_payWithCard();
        setState(() {
          _isLoading = false;
        });
        BottomSnack.successSnackBar(message: body['message'], context: context);
        if (!mounted) return;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PayWebView(
                      url: body['data']['authorization_url'],
                      reference: body['data']['reference'],
                    )));
      } else {
        BottomSnack.errorSnackBar(message: body['message'], context: context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      BottomSnack.errorSnackBar(
          message: 'Something went wrong, please try again later',
          context: context);
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Fund Wallet',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(48, 90, 49, 1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(41),
                          bottomRight: Radius.circular(41),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 150,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/card.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WalletTextField(
                            hintText: 'AMOUNT',
                            controller: _amountController,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: CustomButton(
                text: 'Top up',
                isLoading: _isLoading,
                onTap: () {
                  if (_amountController.text.isNotEmpty) {
                    initiateTransaction(context: context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ));
  }
}
