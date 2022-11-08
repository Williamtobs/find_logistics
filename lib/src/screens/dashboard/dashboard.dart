import 'package:find_logistic/src/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List pages = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: secondaryColor,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/home.svg'),
            activeIcon:
                SvgPicture.asset('assets/images/home.svg', color: primaryColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/history.svg'),
            activeIcon: SvgPicture.asset('assets/images/history.svg',
                color: primaryColor),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/profile.svg'),
            activeIcon: SvgPicture.asset('assets/images/profile.svg',
                color: primaryColor),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
