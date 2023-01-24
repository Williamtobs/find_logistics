import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/app_button.dart';
import 'package:find_logistic/src/screens/widgets/app_ftext_ield.dart';
import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(dashboardProvider);
    final state = ref.watch(profileProvider);
    final model = ref.read(profileProvider.notifier);
    _firstNameController.text = user.user.firstName!;
    _lastNameController.text = user.user.lastName!;
    _emailController.text = user.user.email!;
    _phoneController.text = user.user.phoneNumber!;
    return BaseScreen(
      title: 'Profile',
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
                      controller: _firstNameController,
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
                        controller: _lastNameController,
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
                        controller: _emailController,
                        enabled: false,
                        color: Colors.black),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Phone number',
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
                        controller: _phoneController,
                        color: Colors.black),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              text: 'Update',
              color: primaryColor,
              isLoading: state.isLoading,
              onPressed: () {
                model.updateProfile(
                  context: context,
                  formData: {
                    'first_name': _firstNameController.text,
                    'last_name': _lastNameController.text,
                    'phone_number': _phoneController.text,
                  },
                );
              },
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