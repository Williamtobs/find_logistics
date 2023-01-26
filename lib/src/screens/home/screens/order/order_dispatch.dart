import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/widgets/address_search_field.dart';

import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/inapptextfield.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
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

  String dispatchDay = '';
  String paymentMethod = '';
  final TextEditingController _deliveryAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(pickUpProvider);
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
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  dispatchDay = 'same day';
                });
              },
              child: Row(
                children: [
                  Icon(
                    dispatchDay != 'same day'
                        ? Icons.radio_button_unchecked
                        : Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Same day delivery',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  dispatchDay = 'next day';
                });
              },
              child: Row(
                children: [
                  Icon(
                    dispatchDay != 'next day'
                        ? Icons.radio_button_unchecked
                        : Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Next day delivery',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
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
            InkWell(
              onTap: () {
                setState(() {
                  paymentMethod = 'e-wallet';
                });
              },
              child: Row(
                children: [
                  Icon(
                    paymentMethod != 'e-wallet'
                        ? Icons.radio_button_unchecked
                        : Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'E-wallet',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  paymentMethod = 'cash';
                });
              },
              child: Row(
                children: [
                  Icon(
                    paymentMethod != 'cash'
                        ? Icons.radio_button_unchecked
                        : Icons.radio_button_checked,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cash',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.add, size: 24, color: secondaryColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Add new card',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: CustomButton(
                text: 'Order',
                isLoading: state.isLoading,
                onTap: () {
                  if (_deliveryAddress.text.isNotEmpty) {
                    model.getDeliveryLatLong(
                      context: context,
                      address: _deliveryAddress.text,
                    );
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
