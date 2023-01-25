import 'package:find_logistic/src/screens/auth/login/login.dart';
import 'package:find_logistic/src/screens/home/home.dart';
import 'package:find_logistic/src/utils/app_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStartUp extends ConsumerStatefulWidget {
  const AppStartUp({Key? key}) : super(key: key);

  @override
  ConsumerState<AppStartUp> createState() => _AppStartUpState();
}

class _AppStartUpState extends ConsumerState<AppStartUp> {
  @override
  void initState() {
    super.initState();
    ref.read(dashboardProvider.notifier).getProfile(context: context);
    Future.delayed(const Duration(seconds: 4), () {
      if (ref.read(dashboardProvider).user.id != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // child: const Center(
      //   child: CircularProgressIndicator(),
      // ),
    );
  }
}
