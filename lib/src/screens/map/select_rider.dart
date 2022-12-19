import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectRider extends StatelessWidget {
  const SelectRider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: 26,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Finding Riders near you...',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Material(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.home_outlined,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: EachDriver(
              carName: 'Toyota Corolla (Black)',
              driverName: 'Joseph Nnamdi',
              price: '1200',
            ),
          )
        ],
      ),
    );
  }
}

class EachDriver extends StatelessWidget {
  final String carName, driverName, price;
  const EachDriver(
      {super.key,
      required this.carName,
      required this.driverName,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(248, 255, 237, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/rider_img.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(carName,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(driverName,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      )),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border_outlined,
                        size: 20,
                        color: Color.fromRGBO(45, 95, 46, 1),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '4.5 (117)',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '13 min \n102 m',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 110,
                child: CustomButton(
                  text: 'Decline',
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: 110,
                child: CustomButton(
                  text: 'Accept',
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
