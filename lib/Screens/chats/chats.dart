import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Common/Widget/Containers/chat_container.dart';
import '../../Models/users_model.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.blockSizeWidth!;
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Consumer<UserDetailsProvider>(
          builder: (context, userDetailsProvider, _) {
        UsersModel userDetails = userDetailsProvider.usersModel;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: Row(
              children: [
                Container(
                  width: width * 8,
                  height: width * 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: userDetails.profile ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text('Amenda Cuts',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return chatContainer(context: context);
            },
          ),
        );
      }),
    );
  }
}
