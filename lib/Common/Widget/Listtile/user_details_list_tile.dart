import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Container userDetailsListTile(
    {required BuildContext context,
    required String leading,
    required Function onTap}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
    decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      leading: Text(
        leading,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: GestureDetector(
        onTap: () {
          onTap();
        },
        child: const Icon(
          Iconsax.edit,
        ),
      ),
    ),
  );
}
