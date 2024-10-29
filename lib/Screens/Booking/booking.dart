import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:iconsax/iconsax.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool light1 = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
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
                          text: 'Upcomming',
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
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: service.length,
                              itemBuilder: (context, index) {
                                final data = service[index];
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 10),
                                    child: upcommingContainer(data));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: service.length,
                              itemBuilder: (context, index) {
                                final data = service[index];
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 10),
                                    child: completedContainer(data));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: service.length,
                              itemBuilder: (context, index) {
                                final data = service[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, top: 10),
                                  child: bookingContainer(
                                      data: data, mWidth: mWidth),
                                );
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

  Container upcommingContainer(ServiceModel data) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.blackBackground,
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "13-08-2024 - 10:00AM",
                  style: TextStyle(color: ColorConstants.appTextColor),
                ),
                Row(
                  children: [
                    const Text(
                      "Remind Me",
                      style: TextStyle(color: ColorConstants.appTextColor),
                    ),
                    Switch(
                      activeColor: ColorConstants.appColor,
                      inactiveThumbColor:
                          ColorConstants.appTextColor.withOpacity(0.8),
                      value: light1,
                      onChanged: (bool value) {
                        setState(() {
                          light1 = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: ColorConstants.appTextColor.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(data.serviceImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hair Cut",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConstants.appTextColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        constraints: BoxConstraints(
                          maxWidth: mWidth * 90,
                        ),
                        child: Text(
                          data.serviceName,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: ColorConstants.appTextColor),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        color: ColorConstants.appTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: mWidth * 60,
                      ),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        data.discreption,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: ColorConstants.appColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Divider(
              color: ColorConstants.appTextColor.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                userButttonOutline(
                    width: mWidth * 40, name: "Cancel Booking", onTap: () {}),
                userButtton(
                    color: ColorConstants.appColor,
                    width: mWidth * 40,
                    name: "View E-Receipt",
                    onTap: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container completedContainer(ServiceModel data) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.blackBackground,
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "13-08-2024 - 10:00AM",
                  style: TextStyle(color: ColorConstants.appTextColor),
                ),
                userButtton(
                    width: mWidth * 20,
                    name: "Completed",
                    onTap: () {},
                    color: Colors.green)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: ColorConstants.appTextColor.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(data.serviceImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hair Cut",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConstants.appTextColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        constraints: BoxConstraints(
                          maxWidth: mWidth * 90,
                        ),
                        child: Text(
                          data.serviceName,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: ColorConstants.appTextColor),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        color: ColorConstants.appTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: mWidth * 60,
                      ),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        data.discreption,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: ColorConstants.appColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Divider(
              color: ColorConstants.appTextColor.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16,
            ),
            child: userButttonOutline(
                width: mWidth * 90, name: "View Receipt", onTap: () {}),
          )
        ],
      ),
    );
  }
}

class bookingContainer extends StatelessWidget {
  const bookingContainer({
    super.key,
    required this.data,
    required this.mWidth,
  });

  final ServiceModel data;
  final double mWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.blackBackground,
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "13-08-2024 - 10:00AM",
                  style: TextStyle(color: ColorConstants.appTextColor),
                ),
                userButtton(
                  width: 80.0,
                  name: 'Cancel',
                  onTap: () {},
                  color: ColorConstants.appColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: ColorConstants.appTextColor.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(data.serviceImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hair Cut",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ColorConstants.appTextColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        constraints: BoxConstraints(
                          maxWidth: mWidth * 90,
                        ),
                        child: Text(
                          data.serviceName,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: ColorConstants.appTextColor),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        color: ColorConstants.appTextColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: mWidth * 60,
                      ),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        data.discreption,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: ColorConstants.appColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
