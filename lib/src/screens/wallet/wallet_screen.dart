import 'dart:io';

import 'package:find_logistic/src/app/constant/app_string.dart';
import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/wallet/deposit_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                InkWell(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DepositScreen()));
                  }),
                  child: Container(
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
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (() {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const History()));
            }),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(198, 247, 198, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Transaction History',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text('View All',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
