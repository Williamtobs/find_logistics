import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/forgot_password/reset_password.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyOtp extends ConsumerWidget {
  VerifyOtp({Key? key}) : super(key: key);

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordProvider);
    final model = ref.read(forgotPasswordProvider.notifier);
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter Verification Code',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              'We have sent a verification code to your email address. '
              'Please enter the code below to verify your account.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              hintText: '',
              controller: _otpController,
            ),
            const SizedBox(
              height: 40,
            ),
            AppButton(
                text: 'Verify Code',
                color: primaryColor,
                isLoading: state.isLoading,
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ResetPassword()));
                  model.verifyOtp(context: context, otp: _otpController.text);
                }),
          ],
        ),
      ),
    );
  }
}
