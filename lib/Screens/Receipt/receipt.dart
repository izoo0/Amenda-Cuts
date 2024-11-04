import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:flutter/material.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
        color: ColorConstants.appBackground,
        child: Scaffold(
          backgroundColor: ColorConstants.appBackground,
          appBar: AppBar(
            backgroundColor: ColorConstants.appBackground,
            title: const Text(
              "E-Receipt",
              style: TextStyle(color: ColorConstants.appTextColor),
            ),
          ),
          body: Center(
            child: Text("Receipt"),
          ),
        ));
  }
}
