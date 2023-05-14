import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/app/model/driver_orders_model.dart';
import 'package:find_logistic/src/screens/auth/widgets/auth_background.dart';
import 'package:find_logistic/src/screens/map/select_rider.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverOrderRequest extends ConsumerWidget {
  final DriverOrders driverOrders;
  const DriverOrderRequest({
    super.key,
    required this.driverOrders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderRequestProvider);
    final model = ref.read(orderRequestProvider.notifier);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerRight,
              child: Material(
                elevation: 5,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
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
              ),
            ),
            const SizedBox(height: 20),
            Text('You have a request!',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                )),
            const SizedBox(height: 10),
            Text('You have a request from',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontStyle: FontStyle.italic,
                )),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/map_icon.png',
              width: 126,
              height: 112,
            ),
            const SizedBox(height: 20),
            AuthBackground(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('Name',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                  const SizedBox(height: 5),
                  Text(driverOrders.orderDetails!.sendersName,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: blackColor)),
                  const SizedBox(height: 5),
                  const Divider(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Text('Phone',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(driverOrders.orderDetails!.receiversPhone,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: blackColor)),
                      const Spacer(),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              primaryColor,
                              const Color.fromRGBO(142, 176, 97, 1),
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.call,
                          color: whiteColor,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Text('Pickup Add',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(153, 186, 102, 1))),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.fiber_manual_record,
                        color: Color.fromRGBO(153, 186, 102, 1),
                        size: 16,
                      ),
                      const SizedBox(width: 15),
                      Text(driverOrders.orderDetails!.orderFromAddress,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: blackColor)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Text('Delivery Add',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(252, 61, 61, 1))),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.fiber_manual_record,
                        color: Color.fromRGBO(252, 61, 61, 1),
                        size: 16,
                      ),
                      const SizedBox(width: 15),
                      Text(driverOrders.orderDetails!.orderToAddress,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: blackColor)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Text('Price',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                  const SizedBox(height: 5),
                  Text('N ${driverOrders.orderDetails!.estimatedAmount}',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: blackColor)),
                  const SizedBox(height: 5),
                  const Divider(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    thickness: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Accept',
              size: 200,
              isLoading: state.isLoading,
              onTap: () {
                model.acceptRide(
                    context: context,
                    orderRef: driverOrders.orderDetails!.orderReference);
              },
            ),
            const SizedBox(height: 10),
            const DeclineButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }
}
