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

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorConstants.appColor,
        unselectedItemColor: ColorConstants.appTextColor.withOpacity(0.5),
        showUnselectedLabels: true,
        iconSize: 28,
        selectedFontSize: 12,
        currentIndex: myCurrentIndex,
        backgroundColor: ColorConstants.blackBackground,
        useLegacyColorScheme: false,
        onTap: (int index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: ColorConstants.blackBackground,
            icon: Icon(
              Iconsax.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorConstants.blackBackground,
            icon: Icon(
              Iconsax.gallery,
            ),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorConstants.blackBackground,
            icon: Icon(
              Iconsax.book,
            ),
            label: 'My Booking',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorConstants.blackBackground,
            icon: Icon(
              Iconsax.message,
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            backgroundColor: ColorConstants.blackBackground,
            icon: Icon(
              Iconsax.user,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[myCurrentIndex],
    );
  }
}
