import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Widget chatTextField(
    {required Widget child,
    required BuildContext context,
    required String message,
    required Function onTap,
    required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      children: [
        Expanded(
          child: Card(
            elevation: 3,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                if (message.isNotEmpty) child,
                TextFormField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            onPressed: () {
              onTap();
            },
            icon: const Icon(Iconsax.send_1),
          ),
        )
      ],
    ),
  );
}
