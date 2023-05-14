import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/shared_textfield.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
import 'package:find_logistic/src/screens/widgets/wallet_input_field.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);
    final model = ref.read(forgotPasswordProvider.notifier);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              'assets/images/find_logo.png',
              height: 55,
              width: 73,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/map.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Forgot \nPassword',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 48,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Don’t worry ! It happens. Please enter the mail you registered '
              'with, we will '
              'send your OTP to this mail.',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(91, 88, 88, 1),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter E-mail',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(45, 95, 46, 1),
                      )),
                  const SizedBox(height: 8),
                  SharedField(
                    controller: _emailController,
                    isPassword: false,
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: const WalletTextField(
          //     hintText: 'Enter the Phone Number',
          //   ),
          //   // AppInputField(
          //   //   hintText: "",
          //   //   hint2: 'Enter the Phone Number',
          //   //   controller: _emailController,
          //   // ),
          // ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButton(
              text: "Continue",
              isLoading: state.isLoading,
              size: MediaQuery.of(context).size.width,
              onTap: () {
                model.forgotPassword(
                    context: context, email: _emailController.text);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => const Home()),
                //     (route) => false);
              },
            ),
          ),
          // AppButton(
          //     text: 'Send Verification Code',
          //     color: primaryColor,
          //     isLoading: state.isLoading,
          //     onPressed: () {
          //       // Navigator.push(context,
          //       //     MaterialPageRoute(builder: (context) => VerifyOtp()));
          //       model.forgotPassword(
          //           context: context, email: _emailController.text);
          //     }),
        ],
      ),
    );
  }
}
