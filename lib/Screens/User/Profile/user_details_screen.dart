// ignore_for_file: unnecessary_string_interpolations

import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Containers/user_details_container.dart';
import 'package:amenda_cuts/Common/Widget/Listtile/user_details_list_tile.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Consumer<UserDetailsProvider>(
          builder: (context, userDetailsProvider, _) {
        UsersModel userDetails = userDetailsProvider.usersModel;
        SizeConfig().init(context);
        double height = SizeConfig.blockSizeHeight!;
        double width = SizeConfig.blockSizeWidth!;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              Stack(
                children: [
                  userDetails.profile != null ||
                          (userDetails.profile!.length) > 3
                      ? CachedNetworkImage(
                          imageUrl: userDetails.profile ?? '',
                          height: height * 50,
                          fit: BoxFit.cover,
                        )
                      : Image(
                          image: const AssetImage('assets/Images/on.jpg'),
                          width: double.infinity,
                          height: height * 50,
                          fit: BoxFit.cover,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Iconsax.arrow_left_2,
                          size: 34,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height * 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 64,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userDetails.name ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    userDetails.email ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(fontStyle: FontStyle.italic),
                                  )
                                ],
                              ),
                              userButton(
                                  width: width * 40,
                                  name: "Change Profile",
                                  color: Theme.of(context).primaryColor,
                                  onTap: () {},
                                  context: context)
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              userDetailsContainer(
                                onTap: () {},
                                width: width,
                                height: height,
                                context: context,
                                title: "Location",
                                icon: const Icon(Iconsax.location),
                              ),
                              userDetailsContainer(
                                  width: width,
                                  height: height,
                                  context: context,
                                  title: "Password",
                                  icon: const Icon(Iconsax.lock),
                                  onTap: () {})
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          userDetailsListTile(
                            context: context,
                            leading: userDetails.name ?? '',
                            onTap: () {},
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          userDetailsListTile(
                            context: context,
                            leading: userDetails.email ?? ''.toUpperCase(),
                            onTap: () {},
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          userDetailsListTile(
                            context: context,
                            leading: userDetails.number ?? '',
                            onTap: () {},
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          userDetailsListTile(
                              context: context,
                              leading: userDetails.username ?? '',
                              onTap: () {}),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 35,
                left: width * 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: width * 80,
                  height: height * 10,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 5,
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                        )
                      ],
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.shopping_cart),
                          Text(
                            "My Bookings",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const VerticalDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.archive_tick),
                          Text(
                            "Favorite",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const VerticalDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.archive_tick),
                          Text(
                            "Favorite",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
