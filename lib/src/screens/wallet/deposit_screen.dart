import 'dart:io';

import 'package:find_logistic/src/app/constant/app_string.dart';
import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class DepositScreen extends ConsumerStatefulWidget {
  const DepositScreen({super.key});

  @override
  ConsumerState<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends ConsumerState<DepositScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;
  // final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
  }

  // accessCode() {
  //   return ref.read(walletProvider.notifier).createAccessCode(_getReference(),
  //       int.parse('${_amountController.text}00'), "akeemtobi6@gmail.com");
  // }

  _payWithCard() async {
    // String accessCode = await ref
    //     .read(walletProvider.notifier)
    //     .createAccessCode(_getReference(), int.parse(_amountController.text),
    //         "akeemtobi6@gmail.com");
    PayWithPayStack().now(
        context: context,
        secretKey: paystackPubKey,
        customerEmail: "tobs@gmail.co",
        reference: _getReference(),
        currency: 'NGN',
        amount: '${_amountController.text}00',
        paymentChannel: ["card", "bank"],
        metaData: {
          "custom_fields": [
            {"name": "Akeem William Tobi", "phone": "+2330267268224"}
          ]
        },
        transactionCompleted: () {
          print("Transaction Successful");
          initiateTransaction(context: context, status: 1);
          //ref.read(walletProvider.notifier).verifyOnServer(_getReference());
        },
        transactionNotCompleted: () {
          print("Transaction Not Successful!");
          initiateTransaction(context: context, status: 0);
        });
  }

  initiateTransaction(
      {required BuildContext context, required int status}) async {
    setState(() {
      _isLoading = true;
    });
    var formData = {
      "amount": _amountController.text,
      "reference": _getReference(),
      'email': "tobs@gmail.co",
      'status': status
    };
    try {
      final response = await ref
          .read(networkProvider)
          .postWithToken(formData: formData, path: 'initiate/topup');
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        BottomSnack.successSnackBar(message: body['message'], context: context);
        _payWithCard();
        setState(() {
          _isLoading = false;
        });
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
    final model = ref.read(walletProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text('Amount',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NGN',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Amount',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('Minimum deposit amount is NGN 200',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 30,
            ),
            AppButton(
              text: 'Deposit',
              color: primaryColor,
              isLoading: _isLoading,
              onPressed: () {
                if (_amountController.text.isNotEmpty) {
                  initiateTransaction(context: context, status: 2);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
