import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/customer/register/signup.dart';
import 'package:find_logistic/src/screens/dashboard/dashboard.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final model = ref.read(loginProvider.notifier);

    return Scaffold(
        backgroundColor: secondaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Login',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Container()
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('Email Address',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                      hintText: 'Email Address',
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Password',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    AppTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Forgot Password?',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppButton(
                      text: 'Login',
                      color: primaryColor,
                      isLoading: state.isLoading,
                      onPressed: () {
                        model.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Dashboard()));
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Text('Sign Up',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          )))
                ],
              )
            ],
          ),
        ));
  }
}
