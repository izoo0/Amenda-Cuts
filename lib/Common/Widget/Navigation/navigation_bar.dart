import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int myCurrentIndex = 0;
  List pages = const [Home()];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeHeight!;
    return NavigationBar(
      backgroundColor: ColorConstants.blackBackground,
      height: mHeight * 6,
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Iconsax.home,
            color: ColorConstants.appColor,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Iconsax.gallery),
          label: 'Gallery',
        ),
        NavigationDestination(
          icon: Icon(Iconsax.book),
          label: 'My Booking',
        ),
        NavigationDestination(
          icon: Icon(Iconsax.message),
          label: 'Inbox',
        ),
        NavigationDestination(
          icon: Icon(Iconsax.user_square),
          label: 'Profile',
        ),
      ],
    );
  }
}
