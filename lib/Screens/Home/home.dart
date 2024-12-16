// ignore_for_file: use_build_context_synchronously

import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Widget/BottomSheet/bottom_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Containers/category_container.dart';
import 'package:amenda_cuts/Common/Widget/Containers/service_container.dart';
import 'package:amenda_cuts/Common/Widget/Containers/slider_container.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Functions/Auth/signout/sign_out.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController SearchController;
  SignOut signOut = SignOut();
  @override
  void initState() {
    super.initState();
    SearchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    SearchController.dispose();
  }

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
          toolbarHeight: 60,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: ColorConstants.appBackground,
          title: const Row(
            children: [
              Image(
                image: AssetImage('assets/Logo/logo.png'),
                width: 45,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Amenda Cuts',
                style: TextStyle(color: ColorConstants.appTextColor),
              )
            ],
          ),
          actions: [
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Iconsax.notification_bing,
                size: 25,
                color: ColorConstants.appTextColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                signOut.signOut(context);
              },
              child: const Icon(
                Iconsax.archive_1,
                size: 25,
                color: ColorConstants.appTextColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Morning, Amenda 👋",
                    style: TextStyle(
                      fontSize: 30,
                      color: ColorConstants.appTextColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                commonTextField(
                    controller: SearchController,
                    text: 'Search',
                    maxLines: 1,
                    icon: Iconsax.search_normal,
                    onChange: (value) {},
                    isPassword: false,
                    obscure: false,
                    isSearch: true,
                    validator: (value) {}),
                const SizedBox(
                  height: 15,
                ),
                sliderContainer(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        categoryContainer(
                            child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Image(
                            image: AssetImage('assets/Images/cu.png'),
                            width: 5,
                          ),
                        )),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Haircuts',
                          style: TextStyle(color: ColorConstants.appTextColor),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        categoryContainer(
                            child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Image(
                            image: AssetImage('assets/Images/dr.png'),
                            width: 5,
                          ),
                        )),
                        const Text(
                          'Dreadlocks',
                          style: TextStyle(color: ColorConstants.appTextColor),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        categoryContainer(
                            child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Image(
                            image: AssetImage('assets/Images/c.png'),
                            width: 5,
                          ),
                        )),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Hair Color',
                          style: TextStyle(color: ColorConstants.appTextColor),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        categoryContainer(
                            child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Image(
                            image: AssetImage('assets/Images/p.png'),
                            width: 5,
                          ),
                        )),
                        const Text(
                          'Pedicure',
                          style: TextStyle(color: ColorConstants.appTextColor),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        categoryContainer(
                            child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Image(
                            image: AssetImage('assets/Images/m.png'),
                            width: 5,
                          ),
                        )),
                        const Text(
                          'Manicure',
                          style: TextStyle(color: ColorConstants.appTextColor),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 2,
                  color: ColorConstants.blackBackground,
                ),
                const SizedBox(
                  height: 15,
                ),
                StreamBuilder<List<ServiceModel>>(
                    stream: Apis().fetchServices(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final service = snapshot.data!;

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: service.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data = service[index];
                              bool favorite = false;
                              final documentId = data.documentId;
                              var favorites =
                                  data.favorite.contains(Apis.user?.uid);
                              if (favorites) {
                                favorite = true;
                              }
                              bool isDeleted = data.isDeleted;
                              return isDeleted
                                  ? const Text('data deleted')
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: serviceContainer(
                                          onTap: () {
                                            bottomSheet(
                                              context: context,
                                              height: mHeight * 25,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: mWidth * 90,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: ColorConstants
                                                            .appTextColor
                                                            .withOpacity(0.3)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0,
                                                          vertical: 12),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child: Image(
                                                                image: NetworkImage(
                                                                    data.serviceImage),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Text(
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                data.serviceName,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  color: ColorConstants
                                                                      .appTextColor,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Container(
                                                                constraints:
                                                                    BoxConstraints(
                                                                  maxWidth:
                                                                      mWidth *
                                                                          65,
                                                                ),
                                                                child: Text(
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  data.discreption,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    color: ColorConstants
                                                                        .appTextColor
                                                                        .withOpacity(
                                                                            0.7),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    ' Ksh ${data.servicePrice}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: ColorConstants
                                                                          .appColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  favorites
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            userButtton(
                                                              width:
                                                                  mWidth * 44,
                                                              name: 'Cancel',
                                                              color: ColorConstants
                                                                  .appTextColor
                                                                  .withOpacity(
                                                                      0.3),
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            userButtton(
                                                              width:
                                                                  mWidth * 44,
                                                              name:
                                                                  'Remove Favorite',
                                                              color:
                                                                  ColorConstants
                                                                      .appColor,
                                                              onTap: () {
                                                                Apis().userFavorite(
                                                                    favorite,
                                                                    documentId,
                                                                    Apis.user
                                                                            ?.uid ??
                                                                        '');
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      : userButtton(
                                                          width: mWidth * 90,
                                                          name:
                                                              'Add To Favorites',
                                                          color: ColorConstants
                                                              .appColor,
                                                          onTap: () {
                                                            Apis().userFavorite(
                                                                favorite,
                                                                documentId,
                                                                Apis.user
                                                                        ?.uid ??
                                                                    '');
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                ],
                                              ),
                                            );
                                          },
                                          maxWidth: mWidth * 60,
                                          image: data.serviceImage,
                                          serviceName: data.serviceName,
                                          description: data.discreption,
                                          amount: data.servicePrice,
                                          isFavorite: favorite,
                                          onTapBook: () async {
                                            try {
                                              await Apis().bookNow(
                                                  documentId, Apis.user!.uid);
                                              return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const AnimatedAlertDialog(
                                                      title: "Success",
                                                      content:
                                                          "You have book this service",
                                                    );
                                                  });
                                            } catch (e) {
                                              return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const AnimatedAlertDialog(
                                                      title: "Error",
                                                      content:
                                                          "Failed to book Service",
                                                    );
                                                  });
                                            }
                                          }),
                                    );
                            });
                      } else {
                        return const Text("No data available");
                      }
                    })
              ],
            ),
          ),
        ),
        // bottomNavigationBar: const BottomNavigator(),
      ),
    );
  }
}
