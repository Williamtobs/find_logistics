import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/app/model/negotiate_order_model.dart';
import 'package:find_logistic/src/screens/map/map.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectRider extends ConsumerWidget {
  final num amount;
  final String address, addressTo, orderRef;
  const SelectRider({
    super.key,
    required this.amount,
    required this.orderRef,
    required this.address,
    required this.addressTo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapProvider);
    final model = ref.read(mapProvider.notifier);
    List<NegotiateOrderModel> riders = state.negotiateOrders;
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
                InkWell(
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
          ListView.builder(
              itemCount: riders.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: EachDriver(
                    carName: riders[index].firstName,
                    driverName:
                        '${riders[index].firstName} ${riders[index].lastName}',
                    price: amount.toString(),
                    orderRef: orderRef,
                    driverId: riders[index].id,
                    data: riders[index],
                    address: address,
                    addressTo: addressTo,
                  ),
                );
              })),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: EachDriver(
          //     carName: 'Toyota Corolla (Black)',
          //     driverName: 'Joseph Nnamdi',
          //     price: '1200',
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: EachDriver(
          //     carName: 'Toyota Corolla (Wine)',
          //     driverName: 'Akin Olabode',
          //     price: '1000',
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: EachDriver(
          //     carName: 'Toyota Corolla (Wine)',
          //     driverName: 'Akin Olabode',
          //     price: '900',
          //   ),
          // )
        ],
      ),
    );
  }
}

class EachDriver extends ConsumerWidget {
  final String carName, driverName, price, orderRef;
  final int driverId;
  final String address, addressTo;
  final NegotiateOrderModel data;
  const EachDriver(
      {super.key,
      required this.carName,
      required this.driverName,
      required this.orderRef,
      required this.data,
      required this.driverId,
      required this.address,
      required this.addressTo,
      required this.price});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapProvider);
    final model = ref.read(mapProvider.notifier);
    return Material(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Container(
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
                      '${data.distance} m',
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
            CustomButton(
              text: 'Make offer',
              size: MediaQuery.of(context).size.width,
              onTap: () {
                model.acceptRider(context: context, formData: {
                  'order_reference': orderRef,
                  'user_id': driverId,
                }).then((value) {
                  if (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapScreen(
                                  driverPicked: true,
                                  data: data,
                                  transRef: orderRef,
                                  address: address,
                                  addressTo: addressTo,
                                )));
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class DeclineButton extends StatelessWidget {
  const DeclineButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        height: 47,
        width: 206,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          'Decline',
          style: GoogleFonts.inter(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        )),
      ),
    );
  }
}
