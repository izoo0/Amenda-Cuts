import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:flutter/material.dart';

snackAlert({
  required BuildContext context,
  required String info,
  required icon,
  Widget? child,
}) {
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  return SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    margin: EdgeInsets.only(bottom: 80, left: width * 30, right: width * 30),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    // width: width * 30,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.black45,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  info,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: Colors.black45),
                ),
              ),
              if (child != null) child
            ],
          ),
        ),
      ],
    ),
    backgroundColor: Theme.of(context).primaryColor,
  );
}
