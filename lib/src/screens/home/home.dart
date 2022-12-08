import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/home/widgets/balance.dart';
import 'package:find_logistic/src/screens/home/widgets/options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text('Hello Sharon',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                )),
            const SizedBox(
              height: 5,
            ),
            const BalanceBox(balance: '0.00'),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Options(
                  title: 'Order a Dispatch',
                  img: 'assets/images/dispatch.png',
                ),
                SizedBox(
                  width: 50,
                ),
                Options(
                  title: 'Account',
                  img: 'assets/images/account.png',
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Options(
                  title: 'History',
                  img: 'assets/images/history_home.png',
                ),
                SizedBox(
                  width: 50,
                ),
                Options(
                  title: 'Setting',
                  img: 'assets/images/setting.png',
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Options(
                title: 'Notification',
                img: 'assets/images/notification.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
