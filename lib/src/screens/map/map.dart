import 'package:find_logistic/src/screens/map/select_rider.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 122, 116, 116)),
          ),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                    Container(
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
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    )),
                child: const SelectedLocation(
                  addressFrom: 'Mamre Plain Apartments, lekki, Lagos',
                  addressTo: 'Miskay supermarket, off Blvd St,  Lekki, Lagos',
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SelectedLocation extends StatelessWidget {
  final String addressFrom, addressTo;
  const SelectedLocation({
    super.key,
    required this.addressFrom,
    required this.addressTo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const Icon(
              Icons.fiber_manual_record,
              color: Color.fromRGBO(153, 186, 102, 1),
              size: 8,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              addressFrom,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Color.fromRGBO(217, 217, 217, 1),
            thickness: 1,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Icon(
              Icons.fiber_manual_record,
              color: Color.fromRGBO(252, 61, 61, 1),
              size: 8,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              addressTo,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: Color.fromRGBO(217, 217, 217, 1),
            thickness: 1,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 41,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(153, 186, 102, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.remove, color: Colors.white, size: 20),
              Text(
                'NGN 900',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Icon(Icons.add, color: Colors.white, size: 20),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: SizedBox(
            width: 140,
            child: CustomButton(
              text: 'Find rider',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectRider()));
                //SelectRider
              },
            ),
          ),
        ),
      ],
    );
  }
}
