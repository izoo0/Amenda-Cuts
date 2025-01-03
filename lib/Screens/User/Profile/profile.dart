import 'package:amenda_cuts/Common/Widget/BottomSheet/bottom_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Listtile/profile_list_tile.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/Auth/signout/sign_out.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:amenda_cuts/Provider/theme_provider.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:amenda_cuts/Screens/User/Profile/user_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SignOut instance = SignOut.instance;

  List<String> themes = ['system', 'light', 'dark'];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeHeight!;
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return Consumer<UserDetailsProvider>(
          builder: (context, userDetailsProvider, _) {
        UsersModel userDetails = userDetailsProvider.usersModel;
        return NewAppBackground(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: mHeight * 10,
              scrolledUnderElevation: 0,
              title: Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2, color: Theme.of(context).cardColor)),
                    child: userDetails.profile != null ||
                            (userDetails.profile!.length) > 3
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: userDetails.profile ?? '',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Image(
                            image: AssetImage("assets/Logo/logo.png")),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userDetails.name ?? '',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('${userDetails.email}'.toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? ColorConstants.blackBackground
                                        .withOpacity(0.5)
                                        .withOpacity(0.5)
                                    : ColorConstants.appTextColor
                                        .withOpacity(0.5),
                              )),
                    ],
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Text("user settings".toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? ColorConstants.appTextColor.withOpacity(0.8)
                                : ColorConstants.blackBackground
                                    .withOpacity(0.8))),
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xff008000),
                    icon: Iconsax.user,
                    title: 'Account',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserDetailsScreen()));
                    },
                    subtitle: 'Edit Account Details',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xff006494),
                    icon: Iconsax.broom,
                    title: 'Appearance',
                    onTap: () {
                      bottomSheet(
                        context: context,
                        height: mHeight * 26,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: themes.length,
                            itemBuilder: (_, index) {
                              final themeMode = themes[index];
                              return CheckboxListTile.adaptive(
                                title: Text(themeMode),
                                value: themeProvider.currentTheme == index,
                                onChanged: (bool? val) {
                                  Navigator.pop(context);
                                  if (val != null && val) {
                                    setState(() {
                                      themeProvider.setTheme(index);
                                    });
                                  }
                                  setState(() {});
                                },
                              );
                            }),
                      );
                    },
                    subtitle: 'Light theme, Dark theme',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xfff75c03),
                    icon: Iconsax.notification,
                    title: 'Notification',
                    onTap: () {},
                    subtitle: 'Disable Notification',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xff800000),
                    icon: Iconsax.flag,
                    title: 'Report Problem',
                    onTap: () {},
                    subtitle: 'Talk To Expert',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xffffb703),
                    icon: Iconsax.shield,
                    title: 'Privacy',
                    onTap: () {},
                    subtitle: 'Our Privacy Pollcy',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xff4cc9f0),
                    icon: Iconsax.clipboard_text,
                    title: 'Terms And Conditions',
                    onTap: () {},
                    subtitle: 'Read Our Terms',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xff72195a),
                    icon: Iconsax.info_circle,
                    title: 'About',
                    onTap: () {},
                    subtitle: 'About Application',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xff513b56),
                    icon: Iconsax.global,
                    title: 'Help',
                    onTap: () {},
                    subtitle: 'Assitance',
                    traillignicon: Iconsax.arrow_right,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  listTile(
                    context: context,
                    color: const Color(0xff800000),
                    icon: Iconsax.logout_1,
                    title: 'Log Out',
                    onTap: () async {
                      await instance.signOut(context);
                    },
                    subtitle: 'Exit Application',
                    traillignicon: Iconsax.arrow_right,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
