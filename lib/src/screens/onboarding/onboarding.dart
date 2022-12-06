import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/onboarding/mode_selection.dart';
import 'package:find_logistic/src/screens/onboarding/user_onboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserSelectMode()));
              },
              child: Text('SKIP',
                  style: GoogleFonts.poppins(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _index = index;
                  });
                },
                children: [
                  EachSlide(
                    description:
                        'The Quickest and Easy way to hire a dispatch rider',
                    title: 'Quick and Easy',
                    image: 'assets/images/slide1.svg',
                    index: _index,
                  ),
                  EachSlide(
                    description: 'Deliver now or schedule a delivery for later',
                    title: 'Easy Delivery',
                    image: 'assets/images/slide2.svg',
                    index: _index,
                  ),
                  EachSlide(
                    description:
                        'The Quickest and Easy way to hire a dispatch rider',
                    title: 'Quick and Easy',
                    image: 'assets/images/slide3.svg',
                    index: _index,
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          // AnimatedSmoothIndicator(
          //   activeIndex: _index,
          //   count: 3,
          //   effect: ExpandingDotsEffect(
          //     dotHeight: 10,
          //     dotWidth: 10,
          //     spacing: 5,
          //     activeDotColor: primaryColor,
          //     dotColor: secondaryColor,
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserSelectMode()));
                  },
                  child: Text('SKIP',
                      style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                InkWell(
                  onTap: () {
                    _index == 2
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserSelectMode()))
                        : _pageController.nextPage(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.ease);
                  },
                  child: Text('NEXT',
                      style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EachSlide extends StatelessWidget {
  final String title, description, image;
  final int index;
  const EachSlide(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        SvgPicture.asset(image, height: 300),
        const SizedBox(height: 40),
        AnimatedSmoothIndicator(
          activeIndex: index,
          count: 3,
          effect: ExpandingDotsEffect(
            dotHeight: 10,
            dotWidth: 10,
            spacing: 5,
            activeDotColor: primaryColor,
            dotColor: secondaryColor,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
