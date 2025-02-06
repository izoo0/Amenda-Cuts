import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatInteractionList {
  final Widget leading;
  final String title;

  ChatInteractionList({
    required this.leading,
    required this.title,
  });
}

List<ChatInteractionList> reactionList = [
  ChatInteractionList(
    leading: const Icon(Iconsax.copy),
    title: "Copy",
  ),
  ChatInteractionList(
    leading: const Icon(CupertinoIcons.arrowshape_turn_up_left),
    title: "Reply",
  ),
  ChatInteractionList(
    leading: const Icon(Iconsax.trash),
    title: "Delete",
  ),
  ChatInteractionList(
    leading: const Icon(Iconsax.edit),
    title: "Edit",
  ),
  ChatInteractionList(
    leading: const Icon(Iconsax.sms_star),
    title: "Favorite",
  )
];
