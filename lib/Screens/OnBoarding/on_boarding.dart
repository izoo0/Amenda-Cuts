import 'package:amenda_cuts/Screens/OnBoarding/on_boardig_two.dart';
import 'package:amenda_cuts/Screens/OnBoarding/on_boarding_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent),
      child: PageView(
        children: const [
          OnBoardingOne(),
          OnBoardigTwo(),
        ],
      ),
    );
  }
}
