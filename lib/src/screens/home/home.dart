import 'dart:async';

import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/driver_order/find_orders.dart';
import 'package:find_logistic/src/screens/home/screens/order/order_dispatch.dart';
import 'package:find_logistic/src/screens/home/screens/settings/setting.dart';
import 'package:find_logistic/src/screens/home/screens/wallet/wallet_screen.dart';
import 'package:find_logistic/src/screens/home/widgets/balance.dart';
import 'package:find_logistic/src/screens/home/widgets/options.dart';
import 'package:find_logistic/src/screens/tabs/history/history.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Timer? _timer;
  int _start = 15;

  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).getProfile(context: context);
    _handleLocationPermission();
    ref.read(homeProvider.notifier).fetchRecentActivities();
    initTimer();
  }

  initTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start < 1) {
          _start = 15;
          if (ref.watch(dashboardProvider).user.userType == 'driver') {
            ref.read(homeProvider.notifier).getOrders();
            ref.read(homeProvider.notifier).updateDriverLocation();
          }
        } else {
          _start = _start - 1;
        }
      });
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      BottomSnack.errorSnackBar(
          message: 'Location services are disabled. Please enable the services',
          context: context);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        BottomSnack.errorSnackBar(
            message:
                'Location permissions are denied, activate location service',
            context: context);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      BottomSnack.errorSnackBar(
          message:
              'Location permissions are permanently denied, we cannot request permissions.',
          context: context);
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final home = ref.watch(homeProvider);
    //final model = ref.read(dashboardProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
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
              balance: state.user.wallet.availableBalance != null
                  ? (state.user.wallet.availableBalance!).toString()
                  : '0',
            ),
            const SizedBox(height: 40),
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
                      state.user.userType == 'driver'
                          ? InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const OrderDispatch()));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FindOrders()));
                              },
                              child: const Options(
                                title: 'Check Order',
                                img: 'assets/images/dispatch.png',
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OrderDispatch()));
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const History()));
                        },
                        child: const Options(
                          title: 'History',
                          img: 'assets/images/history_home.png',
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
            const SizedBox(
              height: 10,
            ),
            home.activities.isEmpty
                ? const Center(
                    child: Text('No Recent Activities'),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: home.activities.length > 2
                          ? 2
                          : home.activities.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: EachActivities(
                            time: DateFormat.yMMMEd()
                                .format(home.activities[index].createdAt!),
                            title: home.activities[index].name,
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class EachActivities extends StatelessWidget {
  final String time, title;
  const EachActivities({Key? key, required this.time, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.09),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(4, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                )),
          ),
          const SizedBox(width: 10),
          Text(time,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              )),
        ],
      ),
    );
  }
}
