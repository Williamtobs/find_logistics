import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/onboarding/driver_onboard.dart';
import 'package:find_logistic/src/screens/onboarding/user_onboard.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:flutter/material.dart';

class UserSelectMode extends StatelessWidget {
  const UserSelectMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              text: 'Rider Mode',
              color: Colors.white,
              textColor: primaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DriverOnboard()));
              },
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'Customer Mode',
              color: Colors.white,
              textColor: primaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserOnboard()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
