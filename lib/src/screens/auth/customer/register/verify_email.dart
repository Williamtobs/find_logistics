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
        backgroundColor: tertiaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Verify \nEmail Address!',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                      color: primaryColor,
                    ),
                  ),
                ),
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
                          color: secondaryColor,
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
              ],
            ),
          ),
        ));
  }
}
