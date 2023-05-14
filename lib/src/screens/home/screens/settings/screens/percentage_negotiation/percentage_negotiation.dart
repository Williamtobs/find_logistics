import 'package:find_logistic/src/screens/widgets/basescreen.dart';
import 'package:find_logistic/src/screens/widgets/button.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PercentageNegotiation extends ConsumerStatefulWidget {
  const PercentageNegotiation({super.key});

  @override
  ConsumerState<PercentageNegotiation> createState() =>
      _PercentageNegotiationState();
}

class _PercentageNegotiationState extends ConsumerState<PercentageNegotiation> {
  TextEditingController percentageController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final network = ref.watch(networkProvider);

    updatePercentage() async {
      setState(() {
        isLoading = true;
      });
      final response = await network.postWithToken(
        path: 'percentage-negotiation',
        formData: {
          'percentage_negotiation': percentageController.text.trim(),
        },
      );
      var body = response.data;
      print(body);
      if (response.statusCode == 200) {
        if (body['status'] == true) {
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          BottomSnack.successSnackBar(
              message: body['message'], context: context);
        }
      }
      setState(() {
        isLoading = false;
      });
    }

    return BaseScreen(
      title: 'Percentage Negotiation',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                  child: TextFormField(
                    controller: percentageController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(100, 99, 99, 1),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                      hintStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '%',
                  style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(100, 99, 99, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Update Price Percentage',
              isLoading: isLoading,
              onTap: () {
                updatePercentage();
              },
              size: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
