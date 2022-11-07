import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/login/login.dart';
import 'package:find_logistic/src/screens/auth/register/signup.dart';
import 'package:find_logistic/src/screens/onboarding/driver_onboard.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserOnboard extends StatelessWidget {
  const UserOnboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DriverOnboard()));
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
            Image.asset(
              'assets/images/delivery.png',
              height: 280,
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Find Logistic',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
            const SizedBox(height: 50),
            AppButton(
              text: 'Create Account',
              color: primaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              },
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'Login',
              color: Colors.white,
              textColor: primaryColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const LoginScreen();
                })));
              },
            ),
          ],
        ),
      ),
    );
  }
}
