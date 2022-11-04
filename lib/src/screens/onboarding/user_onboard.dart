import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserOnboard extends StatelessWidget {
  const UserOnboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/delivery-bike.png',
              height: 300,
            ),
            Text('Find Logistic',
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
