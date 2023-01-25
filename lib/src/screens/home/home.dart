import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/home/screens/order/order_dispatch.dart';
import 'package:find_logistic/src/screens/home/screens/settings/setting.dart';
import 'package:find_logistic/src/screens/home/screens/wallet/wallet_screen.dart';
import 'package:find_logistic/src/screens/home/widgets/balance.dart';
import 'package:find_logistic/src/screens/home/widgets/options.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).getProfile(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    //final model = ref.read(dashboardProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            state.isLoading != true
                ? Text('Hello ${state.user.firstName}',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ))
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: const SizedBox(
                      height: 60,
                      width: 150,
                    ),
                  ),
            const SizedBox(
              height: 5,
            ),
            BalanceBox(
                balance: (state.user.wallet!.availableBalance!).toString()),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(249, 255, 240, 1),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //OrderDispatch
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OrderDispatch()));
                        },
                        child: const Options(
                          title: 'Order a Dispatch',
                          img: 'assets/images/dispatch.png',
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WalletScreen()));
                        },
                        child: const Options(
                          title: 'Wallet',
                          img: 'assets/images/wallet.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Options(
                        title: 'History',
                        img: 'assets/images/history_home.png',
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Setting()));
                        },
                        child: const Options(
                          title: 'Setting',
                          img: 'assets/images/setting.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Recent Activities',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: primaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
