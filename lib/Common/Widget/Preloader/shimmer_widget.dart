// import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

shimmerWidget(double width, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).dividerColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(4)),
      width: width,
      height: 10);
}

shimmerWidgets(double width, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
      width: width,
      height: width);
}

Padding shimmerFullWidgets(double mWidth, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).primaryColor.withOpacity(0.5),
          highlightColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerWidgets(mWidth * 8, context),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerWidget(mWidth * 90, context),
                      const SizedBox(height: 6),
                      shimmerWidget(mWidth * 30, context),
                      const SizedBox(height: 6),
                      shimmerWidget(mWidth * 20, context)
                    ]),
              ),
            ],
          )));
}
