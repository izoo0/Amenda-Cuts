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
    leading: const Icon(Iconsax.smileys1),
    title: "React",
  ),
  ChatInteractionList(
    leading: const Icon(Iconsax.copy),
    title: "Copy",
  ),
  ChatInteractionList(
    leading: const Icon(CupertinoIcons.arrowshape_turn_up_left),
    title: "Reply",
  ),
  ChatInteractionList(
    leading: Transform.flip(
      flipX: true,
      child: const Icon(CupertinoIcons.arrowshape_turn_up_left_2),
    ),
    title: "Forward",
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
    leading: const Icon(Icons.star_border),
    title: "Favorite",
  )
];
