import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData whiteTheme() {
  return ThemeData(
      datePickerTheme:
          const DatePickerThemeData(backgroundColor: ColorConstants.appColor),
      primaryColor: ColorConstants.appColor,
      scaffoldBackgroundColor: ColorConstants.appTextColor,
      cardColor: ColorConstants.cardColor,
      dividerColor: ColorConstants.blackBackground,
      brightness: Brightness.light,
      checkboxTheme: const CheckboxThemeData(
          side: BorderSide(
            width: 1,
            color: ColorConstants.appColor,
          ),
          fillColor: WidgetStatePropertyAll<Color>(ColorConstants.appColor)),
      radioTheme: const RadioThemeData(
          fillColor: WidgetStatePropertyAll(ColorConstants.appColor)),
      iconTheme: const IconThemeData(color: ColorConstants.iconColor),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: ColorConstants.blackBackground,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
              color: ColorConstants.blackBackground,
              fontSize: 28,
              fontWeight: FontWeight.w500),
          displaySmall: TextStyle(
              color: ColorConstants.blackBackground,
              fontSize: 24,
              fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(
            color: ColorConstants.blackBackground,
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            color: ColorConstants.blackBackground,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            color: ColorConstants.blackBackground,
            fontSize: 12,
          )));
}