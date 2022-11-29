import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/profile/profile_sreecn.dart';
import 'package:find_logistic/src/screens/tabs/history/history.dart';
import 'package:find_logistic/src/screens/wallet/wallet_screen.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final logout = ref.read(dashboardProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      state.user.firstName!.substring(0, 1),
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //.substring(0,5)
                const SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '${state.user.firstName} ${state.user.lastName}',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ])
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfile()));
              }),
              child: const EachTile(
                icon: Icons.person,
                title: 'Profile',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (() {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const WalletScreen();
                })));
              }),
              child: const EachTile(
                icon: Icons.wallet,
                title: 'Wallet',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (() {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const History();
                })));
              }),
              child: const EachTile(
                icon: Icons.history,
                title: 'Order History',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const EachTile(
              icon: Icons.settings,
              title: 'Settings',
            ),
            const SizedBox(
              height: 5,
            ),
            const EachTile(
              icon: Icons.contact_support,
              title: 'Support/Help',
            ),
            const SizedBox(
              height: 70,
            ),
            InkWell(
              onTap: () {
                logout.logOut(context: context);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'Logout',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EachTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const EachTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 25),
              const SizedBox(
                width: 30,
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 20)
        ],
      ),
    );
  }
}
//settings