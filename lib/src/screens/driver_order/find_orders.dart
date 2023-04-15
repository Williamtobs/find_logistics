import 'package:find_logistic/src/screens/driver_order/driver_map.dart';
import 'package:find_logistic/src/screens/driver_order/order_request.dart';
import 'package:find_logistic/src/screens/map/select_rider.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FindOrders extends ConsumerWidget {
  const FindOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderList = ref.watch(homeProvider).orders;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 40),
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
                  'Finding Orders near you...',
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
          const SizedBox(height: 20),
          orderList.isEmpty
              ? const Center(
                  child: Text('No orders found'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: orderList.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: EachDriver(
                        name: orderList[index].orderDetails!.sendersName,
                        address:
                            orderList[index].orderDetails!.orderFromAddress,
                        price: orderList[index].orderDetails!.estimatedAmount,
                        addressTo:
                            orderList[index].orderDetails!.orderToAddress,
                        image: orderList[index].customerDetails!.image,
                        status: orderList[index].orderDetails!.status,
                        accept: () {
                          if (orderList[index].orderDetails!.status ==
                              'STARTED') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverMap(
                                          driverOrders: orderList[index],
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverOrderRequest(
                                          driverOrders: orderList[index],
                                        )));
                          }
                        },
                      ),
                    );
                  }),
                )
        ],
      ),
    ));
  }
}

class EachDriver extends StatelessWidget {
  final String name, address, price, addressTo, status;
  final String? image;
  final Function()? accept, decline;
  const EachDriver(
      {super.key,
      required this.name,
      required this.address,
      required this.price,
      required this.addressTo,
      this.image,
      this.accept,
      this.decline,
      required this.status});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          NetworkImage(image ?? 'assets/images/rider.png'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          address,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          addressTo,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '₦$price',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: decline,
                      child: DeclineButton(
                        size: MediaQuery.of(context).size.width * 0.4,
                        text: status == 'STARTED' ? 'End' : null,
                      )),
                  CustomButton(
                    text: status == 'STARTED' ? 'Continue Order' : 'View Order',
                    size: MediaQuery.of(context).size.width * 0.4,
                    onTap: accept,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
