import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/home/screens/settings/screens/change_password/change_password.dart';
import 'package:find_logistic/src/screens/home/screens/settings/screens/profile/profile_sreecn.dart';
import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting extends ConsumerStatefulWidget {
  const Setting({super.key});

  @override
  ConsumerState<Setting> createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(dashboardProvider);
    return BaseScreen(
      title: 'Settings',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Account',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()));
                    },
                    child: const EachOption(
                      icon: Icons.person_outline,
                      title: 'Profile',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                    child: const EachOption(
                      icon: Icons.lock_outline,
                      title: 'Password',
                    ),
                  ),
                  const EachOption(
                    icon: Icons.notifications_none_outlined,
                    title: 'Notifications',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'More',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const EachOption(
                    icon: Icons.description_outlined,
                    title: 'Terms and Conditions',
                  ),
                  const SizedBox(height: 20),
                  user.user.userType == 'driver'
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          color: whiteColor,
                          child: Row(
                            children: [
                              Icon(
                                Icons.power_settings_new,
                                size: 22,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Availability',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: primaryColor,
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: primaryColor,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                ref.watch(networkProvider).logout(context: context);
              },
              child: Text('Log Out',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  )),
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

class EachOption extends StatelessWidget {
  final IconData icon;
  final String title;
  const EachOption({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      color: whiteColor,
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: primaryColor,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: primaryColor,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
