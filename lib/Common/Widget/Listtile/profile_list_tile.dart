import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget listTile(
    {required Color color,
    required icon,
    required String title,
    required Function onTap,
    required String subtitle,
    required BuildContext context,
    required traillignicon}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: ListTile(
      leading: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [
                    0,
                    1
                  ],
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.4),
                  ])),
          child: Icon(
            icon,
            color: color,
          )),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall!.apply(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstants.appTextColor.withOpacity(0.5)
                : ColorConstants.blackBackground.withOpacity(0.5)),
      ),
      trailing: Icon(traillignicon),
    ),
  );
}