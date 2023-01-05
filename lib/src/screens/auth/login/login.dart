import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/forgot_password/forgot_password.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
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
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 40,
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
                    'Welcome \nback!',
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          //height: MediaQuery.of(context).size.height * 0.45,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(80),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 5,
                                offset: const Offset(10, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              AppInputField(
                                hintText: "Email Address",
                                controller: _emailController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppInputField(
                                hintText: "Password",
                                controller: _passwordController,
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                text: "Sign In",
                                isLoading: state.isLoading,
                                onTap: () {
                                  model.login(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      context: context);
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => const Home()),
                                  //     (route) => false);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Forgot your password?',
                                      style: GoogleFonts.inter(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      )),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordScreen()));
                                    },
                                    child: Text(
                                      'Reset here',
                                      style: GoogleFonts.inter(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
