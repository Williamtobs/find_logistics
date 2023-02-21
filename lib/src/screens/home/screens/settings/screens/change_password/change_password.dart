import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: 'Change Password',
        child: Padding(
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
                      Text('Current Password',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(100, 99, 99, 1),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        hintText: '',
                        controller: _currentPasswordController,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('New Password',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(100, 99, 99, 1),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        hintText: '',
                        controller: _newPasswordController,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Confirm Password',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(100, 99, 99, 1),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        hintText: '',
                        controller: _confirmPasswordController,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: 'Change Password',
                //isLoading: state.isLoading,
                onTap: () {},
                size: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
