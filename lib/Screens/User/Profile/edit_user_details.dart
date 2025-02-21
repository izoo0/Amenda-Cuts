import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Widget/Alerts/snack_alert.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/loading_widget.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditUserDetails extends StatefulWidget {
  final String title;
  final String value;
  const EditUserDetails({super.key, required this.title, required this.value});

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  late TextEditingController controller;

  Apis instance = Apis.instance;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  String fieldValues(String fieldValue) {
    switch (fieldValue) {
      case "Full Names":
        return 'full_name';
      case "Phone Number":
        return 'phone_number';
      default:
        return 'username';
    }
  }

  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: commonTextField(
                        controller: controller,
                        text: widget.title,
                        maxLines: 1,
                        onChange: (val) {},
                        isPassword: false,
                        obscure: false,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter your ${widget.title}";
                          }
                        },
                        isPrefix: true,
                        icon: (widget.title == "Full Names" ||
                                widget.title == "Username")
                            ? Iconsax.user
                            : Iconsax.call,
                        context: context),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: userButtonOutline(
                      width: double.infinity,
                      name: "Update",
                      context: context,
                      onTap: () async {
                        final fields = fieldValues(widget.title);
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(snackAlert(
                              context: context,
                              info: "updating ${widget.title}",
                              child: loadingWidget(),
                              icon: Iconsax.edit));
                          await instance.editDetails(
                              context: context,
                              value: controller.text.trim(),
                              field: fields);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
