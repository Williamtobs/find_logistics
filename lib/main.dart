import 'package:find_logistic/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/screens/onboarding/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? prefs = await SharedPreferences.getInstance();

  runApp(ProviderScope(
      child: MyApp(
    token: prefs.getString('token'),
  )));
}

class MyApp extends StatefulWidget {
  final String? token;
  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //loggedIn();
    return MaterialApp(
      title: 'Find Logistic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: widget.token == null ? const OnboardingScreen() : const Home(),
    );
  }
}
