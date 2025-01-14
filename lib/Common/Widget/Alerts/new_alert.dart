import 'package:flutter/material.dart';

Widget newAlert({
  required String title,
  required BuildContext context,
  required String body,
  required icon,
}) {
  return AlertDialog(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: Theme.of(context).primaryColor),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              body,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
            child: Text(
              "Close",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: Colors.white),
            ))
      ],
    ),
  );
}
