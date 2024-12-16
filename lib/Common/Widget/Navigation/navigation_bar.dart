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
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).brightness == Brightness.light
            ? ColorConstants.blackBackground.withOpacity(0.5)
            : ColorConstants.appTextColor.withOpacity(0.5),
        showUnselectedLabels: false,
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        currentIndex: myCurrentIndex,
        backgroundColor: Theme.of(context).cardColor,
        useLegacyColorScheme: false,
        onTap: (int index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: const Icon(
              Iconsax.home,
            ),
            label: '.',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: const Icon(
              Iconsax.gallery,
            ),
            label: '.',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: const Icon(
              Iconsax.book,
            ),
            label: '.',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: const Icon(
              Iconsax.message,
            ),
            label: '.',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).cardColor,
            icon: const Icon(
              Iconsax.setting,
            ),
            label: '.',
          ),
        ],
      ),
      body: pages[myCurrentIndex],
    );
  }
}
