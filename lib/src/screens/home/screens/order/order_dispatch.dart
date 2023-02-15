import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/address_search_field.dart';

import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/inapptextfield.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();
    ref.read(orderProvider.notifier).getPaymentMethods();
    ref.read(orderProvider.notifier).getDeliveryMethods();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(pickUpProvider);
    final orderState = ref.watch(orderProvider);
    // final orderModel = ref.read(orderProvider.notifier);
    return BaseScreen(
      title: 'Order a dispatcher',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 30),
            InAppInputField(
              title: 'Pickup',
              hintText: 'Enter pickup details',
              controller: _controller,
            ),
            const SizedBox(height: 15),
            InAppInputField(
              title: 'Receiver\'s Name',
              hintText: 'Enter receiver name',
              controller: _receiverName,
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                AddressSearch().addressFieldTap(context: context).then((value) {
                  if (value != null) {
                    model.placesDetailsResponse = value;
                    _deliveryAddress.text = value.formattedAddress;
                    // print(_deliveryAddress.text);
                  }
                });
              },
              child: InAppInputField(
                title: 'Delivery Point 1',
                hintText: 'Enter delivery address',
                enabled: false,
                controller: _deliveryAddress,
                // controller: _controller,
              ),
            ),
            const SizedBox(height: 15),
            const InAppInputField(
              title: 'Add New Delivery Point',
              hintText: '',
              icon: Icons.add,
              // controller: _controller,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Delivery Type',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: secondaryColor,
              ),
            ),
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
            const SizedBox(
              height: 40,
            ),
            Center(
              child: CustomButton(
                text: 'Order',
                isLoading: state.isLoading,
                onTap: () {
                  if (_deliveryAddress.text.isNotEmpty &&
                      _controller.text.isNotEmpty &&
                      _receiverName.text.isNotEmpty &&
                      dispatchDay != null &&
                      paymentMethod != null) {
                    model.getDeliveryLatLong(
                        context: context,
                        address: _deliveryAddress.text,
                        form: {
                          'pickup_detail': _controller.text,
                          'order_to_address': _deliveryAddress.text,
                          "payment_method_id": paymentMethod,
                          "delivery_type_id": dispatchDay,
                          "receiver_name": _receiverName.text,
                          "order_to_lat": model
                              .placesDetailsResponse!.geometry!.location.lat,
                          "order_to_long": model
                              .placesDetailsResponse!.geometry!.location.lng,
                        });
                  } else {
                    BottomSnack.errorSnackBar(
                        message: 'Enter requires field', context: context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
