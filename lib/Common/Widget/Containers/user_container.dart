import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';

import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';

import 'package:amenda_cuts/Provider/other_user_details_provider.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

Widget userContainer({required BuildContext context}) {
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  double height = SizeConfig.blockSizeHeight!;
  return Consumer<OtherUserDetailsProvider>(
      builder: (context, userDetailsProvider, _) {
    List<OtherUsersModel> otherUserModel = userDetailsProvider.otherUserModel;
    Apis instance = Apis.instance;
    return ListView.builder(
        itemCount: otherUserModel.length,
        itemBuilder: (context, index) {
          final userDetails = otherUserModel[index];
          bool isAdmin;
          bool isExpert = userDetails.isExpert ?? false;
          if (userDetails.role == 'admin' && userDetails.role != null) {
            isAdmin = true;
          } else {
            isAdmin = false;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(3, 4),
                      color: Theme.of(context).shadowColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8)
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: userDetails.profile != null &&
                          (userDetails.profile?.length)! > 2
                      ? CachedNetworkImage(
                          imageUrl: userDetails.profile ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image(
                          image: AssetImage(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 'assets/Logo/logo.png'
                                  : 'assets/Logo/logo_light.jpg'),
                        ),
                ),
                title: Text(userDetails.name ?? ''),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userDetails.email ?? ''),
                    Row(
                      children: [
                        userButton(
                            width: width * 28,
                            name: !isAdmin ? "Make Admin" : "Remove Admin",
                            color: Theme.of(context).primaryColor,
                            onTap: () async {
                              await instance.makeAdmin(
                                  context: context,
                                  userId: userDetails.otherUserId ?? '',
                                  isAdmin: isAdmin);
                            },
                            context: context),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          width: width * 34,
                          height: height * 3.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).primaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(!isExpert ? "Make Expert" : "Remove Expert"),
                              Checkbox(
                                value: isExpert,
                                onChanged: (val) async {
                                  await instance.makeExpert(
                                      context: context,
                                      userId: userDetails.otherUserId ?? '',
                                      isExpert: isExpert);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.trash)),
              ),
            ),
          );
        });
  });
}
