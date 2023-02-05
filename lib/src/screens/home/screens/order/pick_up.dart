import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' show cos, sqrt, asin;

class PickUp extends ConsumerWidget {
  final String deliveryAddress;
  final Map data;
  PickUp({
    super.key,
    required this.deliveryAddress,
    required this.data,
  });

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pickUpAddress = TextEditingController();
  final TextEditingController _pickUpNumber = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(dashboardProvider).user.id;
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(pickUpProvider);
    final orderModel = ref.read(orderProvider.notifier);

    return BaseScreen(
      title: 'Pickup',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              AppInputField(
                hintText: "Sender's Name",
                controller: _controller,
              ),
              const SizedBox(height: 10),
              AppInputField(
                hintText: "Pickup Phone Number",
                controller: _pickUpNumber,
              ),
              const SizedBox(height: 10),
              AppInputField(
                hintText: "Pickup Address",
                controller: _pickUpAddress,
              ),
              const SizedBox(height: 10),
              AppInputField(
                hintText: "Area",
                controller: _controller,
              ),
              const SizedBox(height: 10),
              AppInputField(
                hintText: "Closest Landmark",
                controller: _controller,
              ),
              const SizedBox(height: 40),
              Center(
                child: CustomButton(
                  text: 'Save',
                  isLoading: false,
                  onTap: () {
                    print(userId);
                    orderModel.placeOrder(form: {
                      'customer_id': userId,
                      'order_from_address': 'university of ibadan',
                      'order_to_address': data['order_to_address'],
                      'pickup_details': data['pickup_detail'],
                      'payment_method_id': data['payment_method_id'],
                      'delivery_type_id': data['delivery_type_id'],
                      "order_from_lat": 32433.3434,
                      "order_from_long": 25390.345,
                      "order_to_lat": data['order_to_lat'],
                      "order_to_long": data['order_to_long'],
                      'distance': calculateDistance(32433.3434, 25390.345,
                          data['order_to_lat'], data['order_to_long']),
                      "status": "PENDING",
                      "senders_name": _controller.text,
                      "receivers_name": data['receiver_name'],
                      "receivers_phone": _pickUpNumber.text,
                      "receivers_address": "",
                      "house_number": "",
                      "area": "",
                      "closest_landmark": ""
                    }, context: context);
                    // .then((value) {
                    //   if (value == true) {
                    //     model.getLonglang(
                    //       context: context,
                    //       address: deliveryAddress,
                    //       addressTo: 'university of ibadan',
                    //     );
                    //   }
                    // });
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
    print(distanceInMeters);
    return distanceInMeters * 1000;
  }
}
