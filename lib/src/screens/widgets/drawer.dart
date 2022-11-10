import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
                      color: secondaryColor, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      'D',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'John Doe',
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
            const EachTile(
              icon: Icons.person,
              title: 'Profile',
            ),
            const SizedBox(
              height: 5,
            ),
            const EachTile(
              icon: Icons.wallet,
              title: 'Wallet',
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
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: secondaryColor,
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