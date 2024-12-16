import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget listView({required Function onTap}) {
  return ListView.builder(
      itemCount: listViewItems.length,
      itemBuilder: (context, index) {
        final list = listViewItems[index];
        return ListTile(
            leading: list.icon,
            title: Text(
              list.title,
            ));
      });
}

class DrawerListView {
  final Icon icon;
  final String title;

  DrawerListView({required this.icon, required this.title});
}

List<DrawerListView> listViewItems = [
  DrawerListView(
    icon: const Icon(Iconsax.home),
    title: "Dashboard",
  ),
  DrawerListView(
    icon: const Icon(Iconsax.book),
    title: "Bookings",
  ),
  DrawerListView(
    icon: const Icon(Iconsax.category),
    title: "Category",
  ),
  DrawerListView(
    icon: const Icon(Iconsax.chart),
    title: "Charts",
  ),
  DrawerListView(
    icon: const Icon(Iconsax.user),
    title: "Users",
  )
];
