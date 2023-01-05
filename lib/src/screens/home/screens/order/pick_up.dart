import 'package:find_logistic/src/screens/map/map.dart';
import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/textfield.dart';
import 'package:flutter/material.dart';

class PickUp extends StatelessWidget {
  PickUp({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                controller: _controller,
              ),
              const SizedBox(height: 10),
              AppInputField(
                hintText: "Pickup Address",
                controller: _controller,
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapScreen()));
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
