import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 30,
            // ),
            // Center(
            //   child: Text(
            //     'Order History',
            //     style: GoogleFonts.inter(
            //       fontSize: 24,
            //       fontWeight: FontWeight.w700,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Image.asset(
                'assets/images/history.png',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'No orders yet',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
