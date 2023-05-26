import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/forgot_password/forgot_password.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/shared_textfield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    final model = ref.read(loginProvider.notifier);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Material(
                    elevation: 5,
                    shape: const CircleBorder(),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(45, 95, 46, 1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
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
                  height: 160,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/map.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email Address',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(45, 95, 46, 1),
                            )),
                        const SizedBox(height: 8),
                        SharedField(
                          controller: _emailController,
                          isPassword: false,
                        ),
                        const SizedBox(height: 20),
                        Text('Password',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(45, 95, 46, 1),
                            )),
                        const SizedBox(height: 8),
                        SharedField(
                          controller: _passwordController,
                          isPassword: true,
                          obscureText: _isObscure,
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: "Sign In",
                  isLoading: state.isLoading,
                  onTap: () {
                    model.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                  },
                ),
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
                              builder: (context) => ForgotPasswordScreen()));
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
              const SizedBox(height: 30),
              // Expanded(
              //   child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Container(
              //           width: MediaQuery.of(context).size.width,
              //           //height: MediaQuery.of(context).size.height * 0.45,
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           decoration: BoxDecoration(
              //             color: whiteColor,
              //             borderRadius: const BorderRadius.only(
              //               topRight: Radius.circular(80),
              //             ),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.withOpacity(0.2),
              //                 spreadRadius: 5,
              //                 blurRadius: 5,
              //                 offset: const Offset(10, 4),
              //               ),
              //             ],
              //           ),
              //           child: Column(
              //             children: [
              //               const SizedBox(
              //                 height: 50,
              //               ),
              //               AppInputField(
              //                 hintText: "Email Address",
              //                 controller: _emailController,
              //               ),
              //               const SizedBox(
              //                 height: 10,
              //               ),
              //               PasswordTextfield(
              //                 hintText: "Password",
              //                 controller: _passwordController,
              //                 obscureText: _isObscure,
              //                 onPressed: () {
              //                   setState(() {
              //                     _isObscure = !_isObscure;
              //                   });
              //                 },
              //               ),
              //               const SizedBox(
              //                 height: 20,
              //               ),

              //               const SizedBox(
              //                 height: 20,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ]),
              // )
            ]),
      ),
    );
  }
}
