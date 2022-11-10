import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    //Drawer
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SideDrawer()));
                  },
                  child: const Icon(
                    Icons.menu,
                    size: 30,
                  ),
                ),
                //menu
                const Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Wallet Balance',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text('N 0.00',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('Fund Wallet',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          )),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Order Ride',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.open_in_new, color: Colors.black, size: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
