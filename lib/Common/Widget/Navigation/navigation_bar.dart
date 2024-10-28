import 'package:flutter/material.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Screens/Booking/booking.dart';
import 'package:amenda_cuts/Screens/Gallery/gallery.dart';
import 'package:amenda_cuts/Screens/Home/home.dart';
import 'package:amenda_cuts/Screens/Profile/profile.dart';
import 'package:amenda_cuts/Screens/chats/charts.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int myCurrentIndex = 0;
  List pages = const [
    Home(),
    Gallery(),
    Booking(),
    Chats(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeHeight!;
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: myCurrentIndex,
        backgroundColor: ColorConstants.blackBackground,
        height: mHeight * 6,
        onDestinationSelected: (int index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Iconsax.home,
              color: ColorConstants.appColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.gallery,
              color: ColorConstants.appColor,
            ),
            label: 'Gallery',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.book,
              color: ColorConstants.appColor,
            ),
            label: 'My Booking',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.message,
              color: ColorConstants.appColor,
            ),
            label: 'Inbox',
          ),
          NavigationDestination(
            icon: Icon(
              Iconsax.user_square,
              color: ColorConstants.appColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[myCurrentIndex],
    );
  }
}
