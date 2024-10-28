import 'package:amenda_cuts/Common/Widget/Containers/category_container.dart';
import 'package:amenda_cuts/Common/Widget/Containers/service_containser.dart';
import 'package:amenda_cuts/Common/Widget/Containers/slider_container.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
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
  late bool favorite = false;
  SignOut signOut = SignOut();
  @override
  void initState() {
    super.initState();
    SearchController = TextEditingController();
    favorite = false;
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
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: service.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = service[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: serviceContainer(
                          onTap: () {
                            setState(() {
                              favorite = !favorite;
                            });
                          },
                          maxWidth: mWidth * 60,
                          image: data.serviceImage,
                          serviceName: data.serviceName,
                          discreption: data.discreption,
                          amount: data.servicePrice,
                          isFavorite: favorite,
                        ),
                      );
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
