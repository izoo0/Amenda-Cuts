import 'dart:ui';
import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Calendar/date_picker_widget.dart';
import 'package:amenda_cuts/Common/Widget/Rating/rating_widget.dart';
import 'package:amenda_cuts/Common/Widget/Time/time_picker_widget.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:time_range/time_range.dart';

import '../../../../Common/Widget/Radio/radio_button_widget.dart';

class SingleServiceScreen extends StatefulWidget {
  final ServiceModel serviceModel;
  const SingleServiceScreen({super.key, required this.serviceModel});

  @override
  State<SingleServiceScreen> createState() => _SingleServiceScreenState();
}

class _SingleServiceScreenState extends State<SingleServiceScreen> {
  DateTime _selectedTime = DateTime.now();
  TimeRangeResult? time;
  String serviceLocation = '';

  List<String> location = [
    'shop',
    'home',
  ];
  Apis instance = Apis.instance;

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
    return Consumer<OtherUserDetailsProvider>(
        builder: (context, otherUserDetails, _) {
      final otherUserDetail = otherUserDetails.otherUserModel.firstWhere(
          (details) => details.otherUserId == widget.serviceModel.expertId);
      return Consumer<UserDetailsProvider>(
          builder: (context, userDetailsProvider, _) {
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
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: widget.serviceModel.serviceImage),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SafeArea(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Iconsax.arrow_left_2,
                            size: 32,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                            otherUserDetail.profile ?? ''),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        otherUserDetail.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text(
                                        "Ratings ${otherUserDetail.rating.toString()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .apply(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      ratingBar(
                                        context: context,
                                        initialRating:
                                            otherUserDetail.rating ?? 0,
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
                    height: mHeight * 58,
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
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              widget.serviceModel.serviceName,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.serviceModel.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Choose your location",
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
                                      Text(location.toUpperCase()),
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
                                final today =
                                    DateTime(now.year, now.month, now.day);
                                if (date.isBefore(today)) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AnimatedAlertDialog(
                                          icon: Icon(
                                            Iconsax.info_circle,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          title: "Date",
                                          content:
                                              "Please select a current date",
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
                                }),
                            SizedBox(
                              height: mHeight * 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: mHeight * 10,
                    constraints: BoxConstraints(
                      minHeight: mHeight * 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(instance.dateFormat(date: _selectedTime)),
                              Text(time != null
                                  ? '${time?.start.format(context)}-${time?.end.format(context)}'
                                  : 'Please Select time'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          userButton(
                              width: double.infinity,
                              name: "Book",
                              color: Theme.of(context).primaryColor,
                              onTap: () async {
                                if (time != null) {
                                  await instance.bookNow(
                                      widget.serviceModel.documentId,
                                      userDetailsProvider.user!.uid,
                                      _selectedTime,
                                      '${time?.start.format(context)}-${time?.end.format(context)}',
                                      serviceLocation,
                                      context);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AnimatedAlertDialog(
                                          icon: Icon(
                                            Iconsax.info_circle,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          title: "Time",
                                          content:
                                              "Please select your desired time",
                                        );
                                      });
                                }
                              },
                              context: context)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
