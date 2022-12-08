import 'package:find_logistic/src/app/constant/color.dart';
import 'package:find_logistic/src/screens/onboarding/mode_selection.dart';
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
            height: 40,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('SKIP',
                    style: GoogleFonts.poppins(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
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
                    description: 'From anywhere, regardless of your location',
                    title: 'Find riders near you',
                    image: 'assets/images/slide1.svg',
                    index: _index,
                  ),
                  EachSlide(
                    description:
                        'Negotiate at a reasonable rate to pick a rider.',
                    title: 'Negotiate your price',
                    image: 'assets/images/slide2.svg',
                    index: _index,
                  ),
                  EachSlide(
                    description:
                        'Agree on a fee and a dispatcher would be on its way.',
                    title: 'Order a dispatcher',
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
          Center(
            child: InkWell(
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
              child: SvgPicture.asset(
                  _index == 0
                      ? 'assets/images/next1.svg'
                      : _index == 1
                          ? 'assets/images/next2.svg'
                          : 'assets/images/next3.svg',
                  height: 60,
                  width: 60),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 20,
          //     vertical: 10,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // InkWell(
          //       //   onTap: () {
          //       //     Navigator.push(
          //       //         context,
          //       //         MaterialPageRoute(
          //       //             builder: (context) => const UserSelectMode()));
          //       //   },
          //       //   child: Text('SKIP',
          //       //       style: GoogleFonts.poppins(
          //       //           color: primaryColor,
          //       //           fontSize: 16,
          //       //           fontWeight: FontWeight.w500)),
          //       // ),
          //       InkWell(
          //         onTap: () {
          //           _index == 2
          //               ? Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => const UserSelectMode()))
          //               : _pageController.nextPage(
          //                   duration: const Duration(milliseconds: 800),
          //                   curve: Curves.ease);
          //         },
          //         child: Text('NEXT',
          //             style: GoogleFonts.poppins(
          //                 color: primaryColor,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500)),
          //       ),
          //     ],
          //   ),
          // )
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
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: Asset(image),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        SvgPicture.asset(
          image,
          height: 300,
          width: MediaQuery.of(context).size.width,
        ),
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
        const SizedBox(height: 50),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
