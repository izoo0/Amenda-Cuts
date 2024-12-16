import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

RatingBar ratingBar(
    {required BuildContext context, required double initialRating}) {
  return RatingBar.readOnly(
    isHalfAllowed: true,
    filledIcon: Icons.star,
    halfFilledIcon: Icons.star_half,
    halfFilledColor: Theme.of(context).primaryColor,
    filledColor: Theme.of(context).primaryColor,
    size: 18,
    emptyIcon: Icons.star_border,
    initialRating: initialRating,
    maxRating: 5,
  );
}
