import 'dart:ui';
import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Calendar/date_picker_widget.dart';
import 'package:amenda_cuts/Common/Widget/Time/time_picker_widget.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:time_range/time_range.dart';

import '../../../Common/Widget/Radio/radio_button_widget.dart';

class SingleServiceScreen extends StatefulWidget {
  const SingleServiceScreen({super.key});

  @override
  State<SingleServiceScreen> createState() => _SingleServiceScreenState();
}

class _SingleServiceScreenState extends State<SingleServiceScreen> {
  DateTime _selectedTime = DateTime.now();
  DateTime _pickedDate = DateTime.now();
  TimeRangeResult? time;
  String serviceLocation = '';

  List<String> location = [
    'shop',
    'home',
  ];

  @override
  void initState() {
    super.initState();
    serviceLocation = location[0];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeHeight!;
    double mWidth = SizeConfig.blockSizeWidth!;
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                    height: mHeight * 40,
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://plus.unsplash.com/premium_photo-1658506711778-d56cdeae1b9b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Iconsax.arrow_left_2,
                        size: 24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: mHeight * 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.6),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                    height: mHeight * 8,
                                    width: mHeight * 8,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://plus.unsplash.com/premium_photo-1658506711778-d56cdeae1b9b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gerishom Amenda",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    'Avarage: 4.2',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  RatingBar.readOnly(
                                    isHalfAllowed: true,
                                    filledIcon: Icons.star,
                                    halfFilledIcon: Icons.star_half,
                                    halfFilledColor:
                                        Theme.of(context).primaryColor,
                                    filledColor: Theme.of(context).primaryColor,
                                    size: 18,
                                    emptyIcon: Icons.star_border,
                                    initialRating: 4.2,
                                    maxRating: 5,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: mHeight * 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                  ),
                  child: ListView(
                    shrinkWrap: false,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Text(
                        "Choose your loation",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          ...location.map((location) {
                            return Row(
                              children: [
                                radioListTile(
                                    value: location,
                                    groupValue: serviceLocation,
                                    onChange: (val) {
                                      setState(() {
                                        serviceLocation = val;
                                      });
                                    }),
                                Text(location),
                              ],
                            );
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Date",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      datePicker(
                        selectedTime: _selectedTime,
                        onDateChange: (date) {
                          final now = DateTime.now();
                          final today = DateTime(now.year, now.month, now.day);
                          if (date.isBefore(today)) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AnimatedAlertDialog(
                                    title: "Date",
                                    content: "Please select a current date",
                                  );
                                });
                          } else {
                            setState(() {
                              _selectedTime = date;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Time",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      timeRange(
                          context: context,
                          onRangeCompleted: (range) {
                            setState(() {
                              time = range;
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: mHeight * 10,
                constraints: BoxConstraints(
                  maxHeight: mHeight * 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Theme.of(context).cardColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dateFormat(date: _selectedTime)),
                          Text(time != null
                              ? '${time?.start.format(context)}-${time?.end.format(context)}'
                              : 'Please Select time'),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      userButtton(
                          width: double.infinity,
                          name: "Book Now",
                          color: Theme.of(context).primaryColor,
                          onTap: () {},
                          context: context)
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

String dateFormat({required date}) {
  return DateFormat.yMMMEd().format(date);
}
