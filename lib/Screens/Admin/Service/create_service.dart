import 'dart:io';

import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateService extends StatefulWidget {
  final List<ServiceModel>? serviceModel;
  const CreateService({super.key, this.serviceModel});

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  String expertId = '';
  File serviceImage = File('');
  late bool imageIsEmpty;
  late TextEditingController serviceNameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    serviceNameController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    imageIsEmpty = false;
  }

  @override
  void dispose() {
    super.dispose();
    serviceNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = SizeConfig.blockSizeHeight!;
    return Consumer<OtherUserDetailsProvider>(
        builder: (context, otherUserDetailsProvider, _) {
      List<OtherUsersModel> users = otherUserDetailsProvider.otherUserModel;

      List expert = users.where((user) => user.isExpert == true).toList();
      return NewAppBackground(
          child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Create Service",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await pickImage();
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor,
                          ),
                          child: const Icon(Iconsax.add),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        serviceImage.path.isEmpty
                            ? "Select Image"
                            : "Replace selected image",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButtonFormField<OtherUsersModel>(
                    validator: (value) {
                      if (value == null) {
                        return 'Expert is required';
                      }
                      return null;
                    },
                    items: expert
                        .map((user) => DropdownMenuItem<OtherUsersModel>(
                              value: user,
                              child: Text(user.name),
                            ))
                        .toList(),
                    onChanged: (OtherUsersModel? val) {
                      if (val != null) {
                        setState(() {
                          expertId = val.otherUserId ?? '';
                        });
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Select Expert",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).cardColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: height * 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: !imageIsEmpty
                              ? Theme.of(context).cardColor
                              : Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: serviceImage.path.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              serviceImage,
                              height: height * 30,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.gallery),
                                const SizedBox(width: 10),
                                Text(
                                  "Selected image will appear here",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                  ),
                  if (imageIsEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      child: Text(
                        "Image is required",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  commonTextField(
                    isPrefix: true,
                    controller: serviceNameController,
                    text: "Service Name",
                    maxLines: 1,
                    onChange: (val) {},
                    isPassword: false,
                    obscure: false,
                    validator: (val) {
                      if (val.isEmpty || val == null) {
                        return "Name is required";
                      }
                      return null;
                    },
                    context: context,
                    icon: Iconsax.direct,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  commonTextField(
                    isPrefix: true,
                    controller: priceController,
                    text: "Service Price",
                    maxLines: 1,
                    onChange: (val) {},
                    isPassword: false,
                    obscure: false,
                    validator: (val) {
                      if (val.isEmpty || val == null) {
                        return "Price is required";
                      }
                      return null;
                    },
                    context: context,
                    icon: Iconsax.money,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  commonTextField(
                    isPrefix: false,
                    controller: descriptionController,
                    text: "Service Description",
                    maxLines: 5,
                    onChange: (val) {},
                    isPassword: false,
                    obscure: false,
                    validator: (val) {
                      if (val.isEmpty || val == null) {
                        return "Description is required";
                      }
                      return null;
                    },
                    context: context,
                    icon: Iconsax.money,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  userButtonOutline(
                      width: double.infinity,
                      name: "Create Service",
                      onTap: () {
                        _formKey.currentState!.save();
                        if (serviceImage.path.isEmpty) {
                          setState(() {
                            imageIsEmpty = true;
                          });
                        } else {
                          setState(() {
                            imageIsEmpty = false;
                          });
                        }
                        if (_formKey.currentState!.validate()) {}
                      },
                      context: context)
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? imageFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        setState(() {
          serviceImage = File(imageFile.path);
        });
      }
    } catch (e) {
      //  \
    }
  }
}
