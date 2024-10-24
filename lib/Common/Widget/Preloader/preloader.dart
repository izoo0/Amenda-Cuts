import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget preloader(size) {
  return LoadingAnimationWidget.flickr(
      leftDotColor: ColorConstants.appColor,
      rightDotColor: ColorConstants.appTextColor,
      size: size);
}
