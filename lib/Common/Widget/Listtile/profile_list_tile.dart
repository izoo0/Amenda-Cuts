import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';

Widget listTile(
    {required Color color,
    required icon,
    String? themeType,
    required String title,
    required Function onTap,
    required String subtitle,
    required BuildContext context,
    required trailingIcon}) {
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
      trailing: title == "Appearance"
          ? Text(
              themeType ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Theme.of(context).primaryColor),
            )
          : Icon(trailingIcon),
    ),
  );
}
