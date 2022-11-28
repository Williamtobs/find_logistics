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
              Text('Verify Email Address',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'Please enter the verification code sent to '
                  '${state.user.email} via email to verify your account',
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Didn\'t receive the email?',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () {
                      model.resendOtp(context: context);
                    },
                    child: Text('Resend',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        )),
                  ),
                ],
              ),
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
