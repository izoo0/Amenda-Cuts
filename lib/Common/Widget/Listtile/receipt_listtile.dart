import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget receiptTile({required String leading, required String trailling}) {
  return ListTile(
    leading: Text(
      leading,
      style: const TextStyle(color: ColorConstants.appTextColor),
    ),
    trailing: Text(
      trailling,
      style: const TextStyle(color: ColorConstants.appTextColor),
    ),
  );
}
