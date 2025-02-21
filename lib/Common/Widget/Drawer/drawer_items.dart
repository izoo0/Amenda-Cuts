import 'package:amenda_cuts/Functions/Auth/signout/sign_out.dart';
import 'package:amenda_cuts/Screens/Admin/Bookings/bookings.dart';
import 'package:amenda_cuts/Screens/Admin/Service/service.dart';
import 'package:amenda_cuts/Screens/User/Profile/profile.dart';
import 'package:amenda_cuts/Screens/User/Profile/user_details_screen.dart';
import 'package:amenda_cuts/Screens/chats/chats.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Screens/Admin/Gallery/gallery.dart';
import '../../../Screens/Admin/Users/user_list_screen.dart.dart';
import '../Preloader/preloader.dart';

Widget drawerItems(
    {required bool isActive,
    required String userProfile,
    required String userName,
    required BuildContext context}) {
  SignOut instance = SignOut.instance;
  return SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              if (isActive)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: userProfile,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(userName),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 2,
                      color: Theme.of(context).cardColor.withOpacity(0.3),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserDetailsScreen()));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Iconsax.user_tag),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Profile"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const UserListScreen()));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.people,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Users"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Service()));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.clipboard,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Services"),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Divider(
                thickness: 2,
                color: Theme.of(context).cardColor.withOpacity(0.3),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Chats()));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Iconsax.messages_3),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Messages"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Bookings(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Iconsax.book),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Bookings"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Iconsax.notification_status),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Notifications"),
                ],
              ),
              const SizedBox(height: 5),
              Divider(
                thickness: 2,
                color: Theme.of(context).cardColor.withOpacity(0.3),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AdminGallery()));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Iconsax.gallery),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Gallery"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Iconsax.setting),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Settings"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Row(
                      children: [
                        Text(
                          "Logging out",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        preloader(15.0, context)
                      ],
                    );
                  });
              await instance.signOut(context);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Iconsax.logout_1),
                SizedBox(
                  width: 8,
                ),
                Text("Logout"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
