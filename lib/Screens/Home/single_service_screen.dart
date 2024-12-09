import 'dart:ui';

import 'package:amenda_cuts/Common/Widget/Button/button.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class SingleServiceScreen extends StatefulWidget {
  const SingleServiceScreen({super.key});

  @override
  State<SingleServiceScreen> createState() => _SingleServiceScreenState();
}

class _SingleServiceScreenState extends State<SingleServiceScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeHeight!;
    double mWidth = SizeConfig.blockSizeWidth!;
    return NewAppBackground(
      child: Scaffold(
        backgroundColor: ColorConstants.appBackground,
        body: Stack(
          children: [
            CachedNetworkImage(
                height: mHeight * 50,
                fit: BoxFit.cover,
                imageUrl:
                    'https://plus.unsplash.com/premium_photo-1658506711778-d56cdeae1b9b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            Align(
              alignment: Alignment.bottomCenter,
              child: Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: mHeight * 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstants.appBackground.withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: mHeight * 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                    backgroundBlendMode: BlendMode.multiply,
                    color: ColorConstants.appBackground,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 14,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: mWidth * 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              child: const Text("Booking"),
                            ),
                          ),
                          SizedBox(
                            width: mWidth * 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1,
                                          color:
                                              ColorConstants.blackBackground),
                                      borderRadius: BorderRadius.circular(4))),
                              child: const Text("Portfolio"),
                            ),
                          ),
                          SizedBox(
                            width: mWidth * 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1,
                                        color: ColorConstants.blackBackground),
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                              child: const Text("Reviews"),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text("August 2022"),
                        ],
                      ),
                      DatePicker(
                        DateTime.now(),
                        initialSelectedDate: DateTime.now(),
                        calendarType: CalendarType.gregorianDate,
                        selectionColor: Colors.black,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            // _selectedValue = date;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
