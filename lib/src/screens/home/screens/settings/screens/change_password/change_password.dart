import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final network = ref.watch(networkProvider);

    updatePercentage() async {
      setState(() {
        isLoading = true;
      });
      final response = await network.postWithToken(
        path: 'change/password',
        formData: {
          'current_password': _currentPasswordController.text.trim(),
          'password': _newPasswordController.text.trim(),
          'password_confirmation': _confirmPasswordController.text.trim(),
        },
      );
      var body = response.data;
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          BottomSnack.successSnackBar(
              message: body['message'], context: context);
        } else {
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          BottomSnack.errorSnackBar(message: body['message'], context: context);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        BottomSnack.errorSnackBar(
            message: 'Something went wrong, please try again later',
            context: context);
      }
      setState(() {
        isLoading = false;
      });
    }

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
                isLoading: isLoading,
                onTap: () {
                  if (_currentPasswordController.text.trim().isEmpty) {
                    BottomSnack.errorSnackBar(
                        message: 'Current Password is required',
                        context: context);
                  } else if (_newPasswordController.text.trim().isEmpty) {
                    BottomSnack.errorSnackBar(
                        message: 'New Password is required', context: context);
                  } else if (_confirmPasswordController.text.trim().isEmpty) {
                    BottomSnack.errorSnackBar(
                        message: 'Confirm Password is required',
                        context: context);
                  } else if (_newPasswordController.text.trim() !=
                      _confirmPasswordController.text.trim()) {
                    BottomSnack.errorSnackBar(
                        message: 'Password does not match', context: context);
                  } else {
                    updatePercentage();
                  }
                },
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
