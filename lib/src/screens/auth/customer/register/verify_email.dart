import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmail extends ConsumerWidget {
  VerifyEmail({super.key});

  final TextEditingController _verificationContr = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    final model = ref.read(registerProvider.notifier);
    return Scaffold(
        backgroundColor: secondaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verify Email',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'We have sent a verification link to your email address. '
                  'Enter the code below to verify your email address.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hintText: '',
                controller: _verificationContr,
              ),
              const SizedBox(
                height: 30,
              ),
              Text('Didn\'t receive the email?, Resend',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 40,
              ),
              AppButton(
                  text: 'Verify Email',
                  color: primaryColor,
                  isLoading: state.isLoading,
                  onPressed: () {
                    model.verifyEmail(
                      context: context,
                      otp: _verificationContr.text,
                    );
                  }),
            ],
          ),
        ));
  }
}
