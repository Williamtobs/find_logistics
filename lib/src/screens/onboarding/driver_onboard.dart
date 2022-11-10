import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/onboarding/user_onboard.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverOnboard extends StatelessWidget {
  const DriverOnboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const UserOnboard()));
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.account_circle_outlined,
          size: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/onboard_img.svg',
              height: 300,
            ),
            Text('Rider Onboard',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
            const SizedBox(height: 60),
            AppButton(text: 'Create Account', color: primaryColor),
            const SizedBox(height: 20),
            AppButton(
                text: 'Login', color: Colors.white, textColor: primaryColor),
          ],
        ),
      ),
    );
  }
}