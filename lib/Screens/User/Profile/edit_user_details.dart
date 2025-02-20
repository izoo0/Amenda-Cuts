import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:flutter/material.dart';

class EditUserDetails extends StatefulWidget {
  final String title;
  final String value;
  const EditUserDetails({super.key, required this.title, required this.value});

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
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
                      validator: (val) {},
                      isPrefix: false,
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
                    onTap: () {},
                    context: context,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
