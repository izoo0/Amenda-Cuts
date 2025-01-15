import 'package:flutter/material.dart';

import '../../Constants/color_constants.dart';

LinearGradient linearGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      ColorConstants.appColor.withOpacity(0.4),
      ColorConstants.appColor.withOpacity(0.2)
    ],
    stops: const [0.0, 1.0],
  );
}
