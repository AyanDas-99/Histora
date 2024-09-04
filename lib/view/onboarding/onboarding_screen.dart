import 'package:flutter/material.dart';
import 'package:histora/view/onboarding/screen_2.dart';
import 'package:histora/view/onboarding/screen_3.dart';
import 'package:histora/view/onboarding/widgets/dot_indicator.dart';
import 'package:histora/view/onboarding/widgets/screen_1.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String path = '/onboarding';
  static const String name = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  int page = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        page = pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              children: const [
                Screen1(),
                Screen2(),
                Screen3(),
              ],
            ),
            Positioned(
              left: 10,
              child: DotIndicator(
                length: 3,
                index: page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
