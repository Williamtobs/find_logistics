import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/customer/register/signup.dart';
import 'package:find_logistic/src/screens/auth/login/login.dart';
import 'package:find_logistic/src/screens/auth/riders/register/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSelectMode extends StatelessWidget {
  const UserSelectMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              'Get \nStarted!',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 48,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreenUser()));
              },
              child: const EachButton(
                title: 'Sign Up as User',
                subtitle: 'Let’s find you a dispatcher!',
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RiderSignUpScreen()));
              },
              child: const EachButton(
                title: 'Sign Up as Rider',
                subtitle: 'Start earning on the go!',
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?',
                  style: GoogleFonts.inter(
                    color: primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  )),
              const SizedBox(width: 3),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  //LoginScreen
                },
                child: Text(
                  'Sign In',
                  style: GoogleFonts.inter(
                    color: primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       AppButton(
      //         text: 'Rider Mode',
      //         color: Colors.white,
      //         textColor: primaryColor,
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => const DriverOnboard()));
      //         },
      //       ),
      //       const SizedBox(height: 20),
      //       AppButton(
      //         text: 'Customer Mode',
      //         color: Colors.white,
      //         textColor: primaryColor,
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => const UserOnboard()));
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class EachButton extends StatelessWidget {
  final String title, subtitle;
  const EachButton({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [primaryColor, const Color.fromRGBO(153, 186, 102, 1)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
