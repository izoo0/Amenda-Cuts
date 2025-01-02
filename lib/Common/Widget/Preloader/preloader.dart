import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget preloader(size, BuildContext context) {
  return LoadingAnimationWidget.flickr(
      leftDotColor: Theme.of(context).primaryColor,
      rightDotColor: Theme.of(context).brightness == Brightness.dark
          ? ColorConstants.appTextColor
          : ColorConstants.appBackground,
      size: size);
}
