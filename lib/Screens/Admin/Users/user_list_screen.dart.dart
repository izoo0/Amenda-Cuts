import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:flutter/material.dart';

import '../../../../Common/Widget/Containers/user_container.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: Theme.of(context).shadowColor,
              title: Text(
                "Users",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return userContainer(context: context);
                  }),
            )));
  }
}
