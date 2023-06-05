import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/auth/widgets/auth_background.dart';
import 'package:find_logistic/src/screens/map/map.dart';
import 'package:find_logistic/src/screens/widgets/address_search_field.dart';
import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/shared_textfield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:google_fonts/google_fonts.dart';

class PickUp extends ConsumerStatefulWidget {
  final String deliveryAddress;
  final Map data;
  const PickUp({
    super.key,
    required this.deliveryAddress,
    required this.data,
  });

  @override
  ConsumerState<PickUp> createState() => _PickUpState();
}

class _PickUpState extends ConsumerState<PickUp> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pickUpAddress = TextEditingController();
  final TextEditingController _pickUpNumber = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  int? dispatchDay;
  int? paymentMethod;

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(dashboardProvider).user.id;
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(orderProvider);
    final orderModel = ref.read(orderProvider.notifier);
    final orderState = ref.watch(orderProvider);

    return BaseScreen(
      title: 'Delivery Details',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              AuthBackground(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text('Receiver\'s Name',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    const SizedBox(height: 10),
                    SharedField(
                      controller: _controller,
                      isPassword: false,
                      hint: '',
                    ),
                    const SizedBox(height: 15),
                    Text('Receiver\'s Phone Number',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    const SizedBox(height: 10),
                    SharedField(
                      controller: _pickUpNumber,
                      isPassword: false,
                      hint: '',
                    ),
                    const SizedBox(height: 15),
                    Text('Receiver\'s Address',
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
                            model.pickUpDetailsResponse = value;
                            _pickUpAddress.text = value.formattedAddress;
                            // print(_deliveryAddress.text);
                          }
                        });
                      },
                      child: SharedField(
                        controller: _pickUpAddress,
                        isPassword: false,
                        hint: '',
                        enabled: false,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Text('Area',
                    //     style: GoogleFonts.inter(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 12,
                    //       color: primaryColor,
                    //     )),
                    // const SizedBox(height: 10),
                    // SharedField(
                    //   controller: _areaController,
                    //   isPassword: false,
                    // ),
                    // const SizedBox(height: 15),
                    Text('Closest Landmark',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: primaryColor,
                        )),
                    const SizedBox(height: 10),
                    SharedField(
                      controller: _landmarkController,
                      isPassword: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Delivery Type',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(height: 5),
              orderState.deliveryMethod.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: orderState.deliveryMethod.map((e) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              dispatchDay = e.id;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                dispatchDay != e.id
                                    ? Icons.radio_button_unchecked
                                    : Icons.radio_button_checked,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                e.name,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Payment details',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: secondaryColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              orderState.paymentsMethod.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: orderState.paymentsMethod.map((e) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              paymentMethod = e.id;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                paymentMethod != e.id
                                    ? Icons.radio_button_unchecked
                                    : Icons.radio_button_checked,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                e.name,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 40),
              Center(
                child: CustomButton(
                  text: 'Save',
                  isLoading: state.isLoading,
                  onTap: () {
                    orderModel.placeOrder(form: {
                      'customer_id': userId,
                      'order_from_address': _pickUpAddress.text,
                      'order_to_address': widget.data['order_to_address'],
                      'pickup_details': widget.data['pickup_detail'],
                      'payment_method_id': widget.data['payment_method_id'],
                      'delivery_type_id': widget.data['delivery_type_id'],
                      "order_from_lat":
                          model.pickUpDetailsResponse!.geometry!.location.lat,
                      "order_from_long":
                          model.pickUpDetailsResponse!.geometry!.location.lng,
                      "order_to_lat": widget.data['order_to_lat'],
                      "order_to_long": widget.data['order_to_long'],
                      'distance': calculateDistance(
                          model.pickUpDetailsResponse!.geometry!.location.lat,
                          model.pickUpDetailsResponse!.geometry!.location.lng,
                          widget.data['order_to_lat'],
                          widget.data['order_to_long']),
                      "status": "PENDING",
                      "senders_name": _controller.text,
                      "receivers_name": widget.data['receiver_name'],
                      "receivers_phone": _pickUpNumber.text,
                      "receivers_address": "",
                      "house_number": "",
                      "area": _areaController.text,
                      "closest_landmark": _landmarkController.text
                    }, context: context).then((value) {
                      if (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapScreen(
                                      address: _pickUpAddress.text,
                                      addressTo:
                                          widget.data['order_to_address'],
                                    )));
                      }
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    double distanceInMeters = 12742 * asin(sqrt(a));
    return distanceInMeters * 1000;
  }
}
