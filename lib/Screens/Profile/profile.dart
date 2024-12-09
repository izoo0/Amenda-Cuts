import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/Auth/signout/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SignOut instance = SignOut.instance;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
      color: ColorConstants.appBackground,
      child: Scaffold(
        backgroundColor: ColorConstants.appBackground,
        appBar: AppBar(
          backgroundColor: ColorConstants.blackBackground,
          toolbarHeight: mHeight * 10,
          title: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 1,
                        color: ColorConstants.appTextColor.withOpacity(0.3))),
                child: const Image(image: AssetImage("assets/Logo/logo.png")),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Test User',
                    style: TextStyle(color: ColorConstants.appTextColor),
                  ),
                  Text(
                    'test@gmail.com'.toUpperCase(),
                    style: TextStyle(
                      color: ColorConstants.appTextColor.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  "user settings".toUpperCase(),
                  style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.appTextColor.withOpacity(0.8)),
                ),
              ),
              listTile(
                color: const Color(0xff008000),
                icon: Iconsax.user,
                title: 'Account',
                onTap: () {},
                subtitle: 'Edit Account Details',
                traillignicon: Iconsax.arrow_right,
              ),
              const SizedBox(
                height: 16,
              ),
              listTile(
                color: const Color(0xff006494),
                icon: Iconsax.broom,
                title: 'Appearance',
                onTap: () {},
                subtitle: 'Light theme, Dark theme',
                traillignicon: Iconsax.arrow_right,
              ),
              const SizedBox(
                height: 16,
              ),
              listTile(
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
                color: const Color(0xffffb703),
                icon: Iconsax.shield,
                title: 'Privacy',
                onTap: () {},
                subtitle: 'Our Privacy Pollcy',
                traillignicon: Iconsax.arrow_right,
              ),
              listTile(
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
  }
}

Widget listTile(
    {required Color color,
    required icon,
    required String title,
    required Function onTap,
    required String subtitle,
    required traillignicon}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: ListTile(
      leading: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [
                    0,
                    1
                  ],
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.4),
                  ])),
          child: Icon(
            icon,
            color: color,
          )),
      title: Text(
        title,
        style: TextStyle(
          color: ColorConstants.appTextColor.withOpacity(0.8),
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: ColorConstants.appTextColor.withOpacity(0.5),
          fontSize: 12,
        ),
      ),
      trailing: Icon(traillignicon),
    ),
  );
}
