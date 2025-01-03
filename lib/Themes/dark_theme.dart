import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
      primaryColor: ColorConstants.appColor,
      scaffoldBackgroundColor: ColorConstants.appBackground,
      cardColor: ColorConstants.blackBackground,
      dividerColor: ColorConstants.blackBackground,
      brightness: Brightness.dark,
      shadowColor: ColorConstants.blackBackground,
      radioTheme: const RadioThemeData(
          fillColor: WidgetStatePropertyAll<Color>(ColorConstants.appColor)),
      iconTheme: const IconThemeData(color: ColorConstants.iconColor),
      checkboxTheme: const CheckboxThemeData(
          fillColor: WidgetStatePropertyAll(ColorConstants.appColor),
          side: BorderSide(width: 2, color: ColorConstants.appColor)),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: ColorConstants.appTextColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
              color: ColorConstants.appTextColor,
              fontSize: 28,
              fontWeight: FontWeight.w400),
          displaySmall: TextStyle(
              color: ColorConstants.appTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w300),
          bodyLarge:
              TextStyle(color: ColorConstants.appTextColor, fontSize: 20),
          bodyMedium:
              TextStyle(color: ColorConstants.appTextColor, fontSize: 16),
          bodySmall:
              TextStyle(color: ColorConstants.appTextColor, fontSize: 12)));
}
