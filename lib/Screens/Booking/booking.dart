import 'package:amenda_cuts/Common/Widget/BottomSheet/bottom_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Screens/Booking/canceled.dart';
import 'package:amenda_cuts/Screens/Booking/completed.dart';
import 'package:amenda_cuts/Screens/Booking/upcoming.dart';
import 'package:amenda_cuts/Screens/Receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:iconsax/iconsax.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
      color: ColorConstants.appBackground,
      child: Scaffold(
          backgroundColor: ColorConstants.appBackground,
          appBar: AppBar(
            backgroundColor: ColorConstants.appBackground,
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: ColorConstants.appColor,
                      )),
                  child: const Image(
                    image: AssetImage('assets/Logo/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'My Booking',
                  style: TextStyle(color: ColorConstants.appTextColor),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Iconsax.search_normal,
                    color: ColorConstants.appTextColor.withOpacity(0.7),
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: ButtonsTabBar(
                      backgroundColor: ColorConstants.appColor,
                      unselectedBackgroundColor: Colors.transparent,
                      unselectedBorderColor: ColorConstants.appColor,
                      borderColor: ColorConstants.appColor,
                      borderWidth: 1,
                      contentCenter: true,
                      width: mWidth * 30,
                      radius: 35,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        color: ColorConstants.appTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(
                          text: 'Upcoming',
                        ),
                        Tab(
                          text: 'Completed',
                        ),
                        Tab(
                          text: 'Canceled',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: StreamBuilder<List<OrderModel>>(
                              stream: Apis().fetchBooking(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  print(
                                      "____________________________________________");
                                  print(snapshot.error.toString());
                                }
                                if (snapshot.hasData && snapshot.data != null) {
                                  final service = snapshot.data!;
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: service.length,
                                      itemBuilder: (context, index) {
                                        final data = service[index];
                                        final status = data.status;
                                        bool light1 = data.remindMe ?? false;

                                        return status == 'upcoming'
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0, top: 10),
                                                child: upcommingContainer(
                                                    data, context,
                                                    value: light1,
                                                    onTap: (bool value) {
                                                  Apis().remidMe(
                                                      light1, data.orderId);
                                                }, onCancelTap: () {
                                                  bottomSheet(
                                                      context: context,
                                                      height: mHeight * 25,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          const Text(
                                                            "Cancel Booking",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .redAccent,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12),
                                                            child: Divider(
                                                              color: ColorConstants
                                                                  .appTextColor
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                                    maxWidth:
                                                                        mWidth *
                                                                            70),
                                                            child: const Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              "Are you sure you want to cancel your barber/saloon booking ?",
                                                              style: TextStyle(
                                                                height: 2,
                                                                color: ColorConstants
                                                                    .appTextColor,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              userButtton(
                                                                  width:
                                                                      mWidth *
                                                                          40,
                                                                  name:
                                                                      "Cancel",
                                                                  color: ColorConstants
                                                                      .appTextColor
                                                                      .withOpacity(
                                                                          0.2),
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                              userButtton(
                                                                  width:
                                                                      mWidth *
                                                                          40,
                                                                  name:
                                                                      "Yes cancel booking",
                                                                  color: ColorConstants
                                                                      .appColor,
                                                                  onTap: () {
                                                                    Apis().userCancel(
                                                                        docId: data
                                                                            .orderId);
                                                                    Navigator.pop(
                                                                        context);
                                                                  })
                                                            ],
                                                          )
                                                        ],
                                                      ));
                                                }, openReceipt: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              const Receipt()));
                                                }))
                                            : const SizedBox.shrink();
                                      });
                                } else {
                                  return Center(child: preloader(30.0));
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: StreamBuilder<List<OrderModel>>(
                              stream: Apis().fetchBooking(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  final service = snapshot.data!;
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: service.length,
                                      itemBuilder: (context, index) {
                                        final data = service[index];
                                        final status = data.status;
                                        return status == 'completed'
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0, top: 10),
                                                child: completedContainer(
                                                    data, context))
                                            : const SizedBox();
                                      });
                                } else {
                                  return Center(
                                    child: preloader(30.0),
                                  );
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: StreamBuilder<List<OrderModel>>(
                              stream: Apis().fetchBooking(),
                              builder: (context, snapshot) {
                                final service = snapshot.data;
                                if (snapshot.hasData && snapshot.data != null) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: service?.length,
                                      itemBuilder: (context, index) {
                                        final data = service?[index];
                                        final status = data?.status;
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          return status == 'cancel'
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0, top: 10),
                                                  child: cancelledContainer(
                                                      data!, context),
                                                )
                                              : const SizedBox.shrink();
                                        } else {
                                          return null;
                                        }
                                      });
                                } else {
                                  return Center(
                                    child: preloader(30.0),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
