import 'package:amenda_cuts/Common/Widget/BottomSheet/bottom_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Screens/User/Booking/canceled.dart';
import 'package:amenda_cuts/Screens/User/Booking/completed.dart';
import 'package:amenda_cuts/Screens/User/Booking/upcoming.dart';
import 'package:amenda_cuts/Screens/User/Receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:iconsax/iconsax.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final Apis instance = Apis.instance;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
      color: ColorConstants.appBackground,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const BottomNavigator()));
                },
                icon: const Icon(Iconsax.home)),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image(
                      image: Theme.of(context).brightness == Brightness.dark
                          ? const AssetImage('assets/Logo/logo.png')
                          : const AssetImage('assets/Logo/logo_light.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('My Booking',
                    style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Iconsax.search_normal,
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
                      labelStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.appTextColor
                            : ColorConstants.appBackground,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstants.appTextColor
                            : ColorConstants.appBackground,
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
                              stream: instance.fetchBooking(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  //
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
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      ClipRect(
                                                        child: Image(
                                                          image: AssetImage(
                                                              'assets/Logo/logo.png'),
                                                          width: mWidth * 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "Hello there "),
                                                              Text(
                                                                  "Hello there")
                                                            ],
                                                          )
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ))
                                            : const SizedBox.shrink();
                                      });
                                } else {
                                  return Center(
                                      child: preloader(30.0, context));
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: StreamBuilder<List<OrderModel>>(
                              stream: instance.fetchBooking(),
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
                                    child: preloader(30.0, context),
                                  );
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: StreamBuilder<List<OrderModel>>(
                              stream: instance.fetchBooking(),
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
                                    child: preloader(30.0, context),
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
