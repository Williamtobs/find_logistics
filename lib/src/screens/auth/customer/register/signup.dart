import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/riders/register/signup.dart';
import 'package:find_logistic/src/screens/auth/widgets/auth_background.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/password_textfield.dart';
import 'package:find_logistic/src/screens/widgets/shared_textfield.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:find_logistic/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreenUser extends ConsumerStatefulWidget {
  const SignUpScreenUser({super.key});

  @override
  ConsumerState<SignUpScreenUser> createState() => _SignUpScreenUserState();
}

class _SignUpScreenUserState extends ConsumerState<SignUpScreenUser> {
  String _countryCode = '234';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);
    final model = ref.read(registerProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
            setState(() {
              _formKey.currentState!.validate();
            });
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 60),
                SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/cloud2.png',
                          height: 38,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'assets/images/cloud1.png',
                          height: 38,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Text("Sign up as User",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: primaryColor,
                    )),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AuthBackground(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('First Name',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(45, 95, 46, 1),
                            )),
                        const SizedBox(height: 8),
                        SharedField(
                          controller: _firstNameController,
                          isPassword: false,
                        ),
                        const SizedBox(height: 10),
                        Text('Last Name',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(45, 95, 46, 1),
                            )),
                        const SizedBox(height: 8),
                        SharedField(
                          controller: _lastNameController,
                          isPassword: false,
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        Text('Phone Number',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(45, 95, 46, 1),
                            )),
                        const SizedBox(height: 8),
                        SharedField(
                          controller: _phoneController,
                          isPassword: false,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Password',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(45, 95, 46, 1),
                                )),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                  '(must contain an uppercase, special character & 8 characters long)',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(45, 95, 46, 1),
                                  )),
                            ),
                          ],
                        ),
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
                        const SizedBox(height: 10),
                        Text('Confirm Password',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(45, 95, 46, 1),
                            )),
                        const SizedBox(height: 8),
                        SharedField(
                          controller: _confirmPasswordController,
                          isPassword: true,
                          obscureText: _isObscure2,
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: CustomButton(
                            text: "Sign Up",
                            isLoading: state.isLoading,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                model.register(context: context, formData: {
                                  'first_name': _firstNameController.text,
                                  'last_name': _lastNameController.text,
                                  'email': _emailController.text,
                                  'phone_number':
                                      '$_countryCode${_phoneController.text}',
                                  "user_type": "user",
                                  'password': _passwordController.text,
                                  'password_confirmation':
                                      _confirmPasswordController.text,
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Are you a rider?',
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
                                            const RiderSignUpScreen()));
                              },
                              child: Text(
                                'Sign up here',
                                style: GoogleFonts.inter(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
