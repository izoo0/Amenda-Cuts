import 'package:amenda_cuts/Screens/Admin/User/user_list_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget drawerItems(
    {required bool isActive,
    required String userProfile,
    required String userName,
    required BuildContext context}) {
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
              const Row(
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
                      Iconsax.clipboard,
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
              const Row(
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
                  Text("Services"),
                ],
              ),
              const SizedBox(height: 5),
              Divider(
                thickness: 2,
                color: Theme.of(context).cardColor.withOpacity(0.3),
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Iconsax.scissor),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Experts"),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
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
              const SizedBox(height: 20),
              const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Iconsax.message_notif),
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
              const Row(
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
              const SizedBox(height: 20),
              const Row(
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
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
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
        ],
      ),
    ),
  );
}
