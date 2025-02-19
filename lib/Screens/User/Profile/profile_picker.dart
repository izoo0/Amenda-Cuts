import 'dart:io';

import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Widget/Alerts/alerts.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Functions/NodeAPI/node_api.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePicker extends StatefulWidget {
  const ProfilePicker({super.key});

  @override
  State<ProfilePicker> createState() => _ProfilePickerState();
}

class _ProfilePickerState extends State<ProfilePicker> {
  String imageFile = "";
  NodeApi instance = NodeApi.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
        builder: (context, userDetailsProvider, _) {
      return NewAppBackground(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).cardColor,
              title: Text(
                "Pick Image",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DottedBorder(
                      dashPattern: const [6, 4],
                      borderType: BorderType.RRect,
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image(
                            image: imageFile.isEmpty
                                ? userDetailsProvider.usersModel.profile == null
                                    ? const AssetImage(
                                        "assets/Logo/logo_light.jpg")
                                    : NetworkImage(userDetailsProvider
                                            .usersModel.profile ??
                                        '')
                                : FileImage(File(imageFile)),
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () async {
                              await pickImage();
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Iconsax.edit,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Select Image")
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          userDetailsProvider.usersModel.profile == null
                              ? InkWell(
                                  onTap: () async {
                                    if (imageFile.isNotEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return preloader(16.0, context);
                                          });
                                      await instance.createUserProfile(
                                          image: imageFile, context: context);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AnimatedAlertDialog(
                                                title: "Error",
                                                content:
                                                    "Please select an image",
                                                icon: Icon(
                                                  Iconsax.info_circle,
                                                  size: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ));
                                          });
                                    }
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Iconsax.document_upload,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Save Image")
                                    ],
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (imageFile.isNotEmpty) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return preloader(16.0, context);
                                          });
                                      await instance.editUserProfile(
                                          image: imageFile, context: context);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AnimatedAlertDialog(
                                                title: "Error",
                                                content:
                                                    "Please select an image",
                                                icon: Icon(
                                                  Iconsax.info_circle,
                                                  size: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ));
                                          });
                                    }
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Iconsax.document_upload,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Update Image")
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file!.path.isNotEmpty) {
      setState(() {
        imageFile = file.path;
      });
    }
  }
}
