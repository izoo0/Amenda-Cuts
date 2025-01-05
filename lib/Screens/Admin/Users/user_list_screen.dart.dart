import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Screens/User/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../Common/Widget/Containers/user_container.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  bool searchText = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: Theme.of(context).shadowColor,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const BottomNavigator()));
                  },
                  icon: const Icon(Iconsax.home)),
              title: !searchText
                  ? Text(
                      "Users",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : commonTextField(
                      controller: controller,
                      text: "Search...",
                      maxLines: 1,
                      onChange: (val) {},
                      isPassword: false,
                      obscure: false,
                      validator: (val) {},
                      context: context,
                      isSearch: true,
                      icon: Iconsax.search_normal,
                    ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        searchText = !searchText;
                      });
                    },
                    icon: Icon(!searchText
                        ? Iconsax.search_normal
                        : Iconsax.close_circle))
              ],
            ),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: userContainer(context: context))));
  }
}
