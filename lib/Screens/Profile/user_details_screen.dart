import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                userDetails.profile != null || (userDetails.profile!.length) > 3
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Theme.of(context).cardColor),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
