import 'package:amenda_cuts/Screens/User/Profile/edit_user_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Container userDetailsListTile(
    {required BuildContext context,
    required String title,
    required String subtitle}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 3),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: title == "Email"
          ? null
          : GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EditUserDetails(title: title, value: subtitle)));
              },
              child: const Icon(
                Iconsax.edit,
              ),
            ),
    ),
  );
}
