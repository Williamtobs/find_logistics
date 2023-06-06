import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/widgets/auth_background.dart';
import 'package:find_logistic/src/screens/widgets/address_search_field.dart';

import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/shared_textfield.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pick_up.dart';

class OrderDispatch extends ConsumerStatefulWidget {
  const OrderDispatch({super.key});

  @override
  ConsumerState<OrderDispatch> createState() => _OrderDispatchState();
}

class _OrderDispatchState extends ConsumerState<OrderDispatch> {
  final TextEditingController _controller = TextEditingController();

  int? dispatchDay;
  int? paymentMethod;
  final TextEditingController _deliveryAddress = TextEditingController();
  final TextEditingController _receiverName = TextEditingController();

  bool addressValue = false;
  List addressList = [];
  String? selected;

  @override
  void initState() {
    super.initState();
    ref.read(orderProvider.notifier).getPaymentMethods();
    ref.read(orderProvider.notifier).getDeliveryMethods();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(dashboardProvider);
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(pickUpProvider);
    // final orderState = ref.watch(orderProvider);

    getAddress(address) async {
      addressList = await model.getLatLong(address: address);
    }

    // final orderModel = ref.read(orderProvider.notifier);
    return BaseScreen(
      title: 'Pick up Details',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            AuthBackground(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Use current address',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                            value: addressValue,
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                addressValue = value;
                                if (addressValue) {
                                  _deliveryAddress.text = user.user.address;
                                  getAddress(user.user.address);
                                } else {
                                  _deliveryAddress.text = '';
                                }
                              });
                            })
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Sender\'s Name',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    const SizedBox(height: 10),
                    SharedField(
                      controller: _receiverName,
                      isPassword: false,
                      hint: '',
                    ),
                    const SizedBox(height: 15),
                    Text('Pickup Address',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        AddressSearch()
                            .addressFieldTap(context: context)
                            .then((value) {
                          if (value != null) {
                            model.placesDetailsResponse = value;
                            _deliveryAddress.text = value.formattedAddress;
                          }
                        });
                      },
                      child: SharedField(
                        controller: _deliveryAddress,
                        isPassword: false,
                        hint: 'E.g No 8, ABCD Street',
                        enabled: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Delivery Type',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: secondaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          selected != 'Document'
                              ? Icons.radio_button_unchecked
                              : Icons.radio_button_checked,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Document',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          selected != 'Food/Drinks'
                              ? Icons.radio_button_unchecked
                              : Icons.radio_button_checked,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Food/Drinks',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          selected != 'Others'
                              ? Icons.radio_button_unchecked
                              : Icons.radio_button_checked,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Others',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Detail of Package (Optional)',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    const SizedBox(height: 10),
                    SharedField(
                      controller: _controller,
                      isPassword: false,
                      hint: 'Optional',
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: CustomButton(
                        text: 'Next',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PickUp(
                                        deliveryAddress: '',
                                        data: {},
                                      )));
                        },
                      ),
                    )
                  ]),
            ),
            // InAppInputField(
            //   title: 'Pickup',
            //   hintText: 'Enter pickup details',
            //   controller: _controller,
            // ),
            // const SizedBox(height: 15),
            // InkWell(
            //   onTap: () {
            //     AddressSearch().addressFieldTap(context: context).then((value) {
            //       if (value != null) {
            //         model.placesDetailsResponse = value;
            //         _deliveryAddress.text = value.formattedAddress;
            //         // print(_deliveryAddress.text);
            //       }
            //     });
            //   },
            //   child: InAppInputField(
            //     title: 'Delivery Point 1',
            //     hintText: 'Enter delivery address',
            //     enabled: false,
            //     controller: _deliveryAddress,
            //     // controller: _controller,
            //   ),
            // ),
            // const SizedBox(height: 15),
            // const InAppInputField(
            //   title: 'Add New Delivery Point',
            //   hintText: '',
            //   icon: Icons.add,
            //   // controller: _controller,
            // ),
            const SizedBox(height: 20),
            // Text(
            //   'Delivery Type',
            //   style: GoogleFonts.inter(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w700,
            //     color: secondaryColor,
            //   ),
            // ),
            // const SizedBox(height: 5),
            // orderState.deliveryMethod.isEmpty
            //     ? const SizedBox.shrink()
            //     : Column(
            //         children: orderState.deliveryMethod.map((e) {
            //           return InkWell(
            //             onTap: () {
            //               setState(() {
            //                 dispatchDay = e.id;
            //               });
            //             },
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   dispatchDay != e.id
            //                       ? Icons.radio_button_unchecked
            //                       : Icons.radio_button_checked,
            //                   color: primaryColor,
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Text(
            //                   e.name,
            //                   style: GoogleFonts.inter(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w500,
            //                     color: primaryColor,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         }).toList(),
            //       ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   'Payment details',
            //   style: GoogleFonts.inter(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w700,
            //     color: secondaryColor,
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // orderState.paymentsMethod.isEmpty
            //     ? const SizedBox.shrink()
            //     : Column(
            //         children: orderState.paymentsMethod.map((e) {
            //           return InkWell(
            //             onTap: () {
            //               setState(() {
            //                 paymentMethod = e.id;
            //               });
            //             },
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   paymentMethod != e.id
            //                       ? Icons.radio_button_unchecked
            //                       : Icons.radio_button_checked,
            //                   color: primaryColor,
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Text(
            //                   e.name,
            //                   style: GoogleFonts.inter(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w500,
            //                     color: primaryColor,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         }).toList(),
            //       ),
            const SizedBox(
              height: 40,
            ),
            // Center(
            //   child: CustomButton(
            //     text: 'Order',
            //     isLoading: state.isLoading,
            //     onTap: () {
            //       // if (_deliveryAddress.text.isNotEmpty &&
            //       //     _controller.text.isNotEmpty &&
            //       //     _receiverName.text.isNotEmpty &&
            //       //     dispatchDay != null &&
            //       //     paymentMethod != null) {
            //       //   // model.getDeliveryLatLong(
            //       //   //     context: context,
            //       //   //     address: _deliveryAddress.text,
            //       //   //     form: {
            //       //   //       'pickup_detail': _controller.text,
            //       //   //       'order_to_address': _deliveryAddress.text,
            //       //   //       "payment_method_id": paymentMethod,
            //       //   //       "delivery_type_id": dispatchDay,
            //       //   //       "receiver_name": _receiverName.text,
            //       //   //       "order_to_lat": addressValue == false
            //       //   //           ? model
            //       //   //               .placesDetailsResponse!.geometry!.location.lat
            //       //   //           : addressList[0],
            //       //   //       "order_to_long": addressValue == false
            //       //   //           ? model
            //       //   //               .placesDetailsResponse!.geometry!.location.lng
            //       //   //           : addressList[1],
            //       //   //     });
            //       // } else {
            //       //   BottomSnack.errorSnackBar(
            //       //       message: 'Enter requires field', context: context);
            //       // }
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
