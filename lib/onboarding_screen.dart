// import 'package:eco_feast/constants.dart';
// import 'package:eco_feast/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'constants_ui.dart';
import 'welcome_screen.dart';

import 'onboarding_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingWidget> pages = [
    const OnboardingWidget(
      title: 'Discover Sustainable Recipes',
      description:
      'Explore a variety of delicious and sustainable recipes \nright from your mobile.',
      imagePath: ImageConstants.onboardImage1,
    ),
    const OnboardingWidget(
      title: 'Cook Eco-Friendly Meals',
      description:
      'Learn how to cook meals with a low carbon footprint \nand eco-friendly ingredients.',
      imagePath: ImageConstants.onboardImage2,
    ),
    const OnboardingWidget(
      title: 'Join Daily Challenges',
      description:
      'Participate in daily sustainability challenges \nto earn rewards and make a positive impact.',
      imagePath: ImageConstants.onboardImage3,
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        foregroundColor: ColorConstants.primaryColor),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Previous'),
                  ),
                if (currentPage < pages.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorConstants.primaryColor,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Next'),
                  ),
                if (currentPage == pages.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorConstants.primaryColor,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                      );
                    },
                    child: const Text('Done'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
