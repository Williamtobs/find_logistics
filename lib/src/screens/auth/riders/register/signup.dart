import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/customer/register/signup.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/password_textfield.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:find_logistic/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderSignUpScreen extends ConsumerStatefulWidget {
  const RiderSignUpScreen({super.key});

  @override
  ConsumerState<RiderSignUpScreen> createState() => _RiderSignUpScreenState();
}

class _RiderSignUpScreenState extends ConsumerState<RiderSignUpScreen> {
  String _countryCode = '234';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);
    final model = ref.read(registerProvider.notifier);

    return Scaffold(
      backgroundColor: tertiaryColor,
      body: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
          setState(() {
            _formKey.currentState!.validate();
          });
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
              Container(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Sign up as Rider",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: primaryColor,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      AppInputField(
                        hintText: "First Name",
                        controller: _firstNameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppInputField(
                        hintText: "Last Name",
                        controller: _lastNameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        hintText: "Email Address",
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        hintText: "Phone Number",
                        controller: _phoneController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        hintText: "Plate Number",
                        controller: _plateController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordTextfield(
                        hintText: "Password",
                        controller: _passwordController,
                        obscureText: _isObscure,
                        validator: Validators.validatePassword(),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordTextfield(
                        hintText: "Confirm Password",
                        controller: _confirmPasswordController,
                        obscureText: _isObscure2,
                        validator: Validators.validatePassword(),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
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
                              'plate_number': _plateController.text,
                              "user_type": "driver",
                              'password': _passwordController.text,
                              'password_confirmation':
                                  _confirmPasswordController.text,
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Are you a user?',
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
                                          const SignUpScreenUser()));
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
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
