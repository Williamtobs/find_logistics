import 'package:find_logistic/src/screens/map/map.dart';
import 'package:find_logistic/src/screens/widgets/address_search_field.dart';
import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' show cos, sqrt, asin;

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

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(dashboardProvider).user.id;
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(orderProvider);
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
                child: AppInputField(
                  hintText: "Pickup Address",
                  controller: _pickUpAddress,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 10),
              AppInputField(
                hintText: "Area",
                controller: _areaController,
              ),
              const SizedBox(height: 10),
              AppInputField(
                hintText: "Closest Landmark",
                controller: _landmarkController,
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
    print(distanceInMeters);
    return distanceInMeters * 1000;
  }
}
