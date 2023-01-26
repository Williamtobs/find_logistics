import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PickUp extends ConsumerWidget {
  final String deliveryAddress;
  PickUp({
    super.key,
    required this.deliveryAddress,
  });

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pickUpAddress = TextEditingController();
  final TextEditingController _pickUpNumber = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(pickUpProvider.notifier);
    final state = ref.watch(pickUpProvider);

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
                  isLoading: state.isLoading,
                  onTap: () {
                    model.getLonglang(
                      context: context,
                      address: deliveryAddress,
                      addressTo: _pickUpAddress.text,
                    );
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
}
