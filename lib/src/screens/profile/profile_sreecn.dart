import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (() {
                            Navigator.pop(context);
                          }),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('First Name',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                      hintText: 'First Name',
                      controller: TextEditingController(),
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Last Name',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                        hintText: 'Last Name',
                        controller: TextEditingController(),
                        color: Colors.black),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Email',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                        hintText: 'Email Address',
                        controller: TextEditingController(),
                        color: Colors.black),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Phone',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                        hintText: 'Phone Number',
                        controller: TextEditingController(),
                        color: Colors.black),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              text: 'Save',
              color: primaryColor,
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
