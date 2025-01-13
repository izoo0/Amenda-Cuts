import 'dart:io';

import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Functions/NodeAPI/node_api.dart';
import 'package:amenda_cuts/Models/category_model.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:dotted_border/dotted_border.dart';
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
  String selectedCategory = '';
  File serviceImage = File('');
  late bool imageIsEmpty;
  late TextEditingController serviceNameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  NodeApi instance = NodeApi.instance;
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
    double width = SizeConfig.blockSizeWidth!;
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
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButtonFormField<CategoryModel>(
                    borderRadius: BorderRadius.circular(4),
                    icon: const Icon(Iconsax.arrow_circle_down),
                    hint: const Text("Select Category"),
                    dropdownColor: Theme.of(context).cardColor,
                    validator: (value) {
                      if (value == null) {
                        return 'Category is required';
                      }
                      return null;
                    },
                    items: categories
                        .map((user) => DropdownMenuItem<CategoryModel>(
                              value: user,
                              child: Text(user.categoryName),
                            ))
                        .toList(),
                    onChanged: (CategoryModel? val) {
                      if (val != null) {
                        setState(() {
                          selectedCategory = val.categoryName;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).cardColor),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<OtherUsersModel>(
                    icon: const Icon(Iconsax.arrow_circle_down),
                    alignment: Alignment.bottomCenter,
                    dropdownColor: Theme.of(context).cardColor,
                    hint: const Text("Select Expert"),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 1, color: Theme.of(context).cardColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1, color: Theme.of(context).primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.red)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DottedBorder(
                    strokeWidth: 3,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    dashPattern: const [6, 5],
                    color: !imageIsEmpty
                        ? Theme.of(context).cardColor
                        : Colors.red,
                    child: SizedBox(
                      width: double.infinity,
                      height: height * 30,
                      child: serviceImage.path.isNotEmpty
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    serviceImage,
                                    height: height * 30,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  left: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        serviceImage = File('');
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          shape: BoxShape.circle),
                                      child: const Icon(Iconsax.close_circle),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: Center(
                                child: DottedBorder(
                                  radius: const Radius.circular(8),
                                  borderType: BorderType.RRect,
                                  color: Theme.of(context).cardColor,
                                  strokeWidth: 2,
                                  dashPattern: const [6, 5],
                                  borderPadding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    width: width * 35,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.gallery),
                                        const SizedBox(width: 10),
                                        Text(
                                          "Selected image",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  if (imageIsEmpty)
                    const SizedBox(
                      height: 4,
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
                      onTap: () async {
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

                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: preloader(20.0, context),
                                  ),
                                );
                              });
                          await instance.createService(
                              context: context,
                              image: serviceImage,
                              expertId: expertId,
                              selectedCategory: selectedCategory,
                              name: serviceNameController.text.trim(),
                              price: priceController.text.trim(),
                              description: descriptionController.text.trim());
                          serviceNameController.clear();
                          priceController.clear();
                          descriptionController.clear();
                          setState(() {
                            serviceImage = File('');
                          });
                        }
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
