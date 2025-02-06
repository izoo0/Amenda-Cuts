import 'package:flutter/material.dart';

class DeleteAnimatedAlert extends StatefulWidget {
  final String title;
  final String body;
  const DeleteAnimatedAlert({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<DeleteAnimatedAlert> createState() => _DeleteAnimatedAlertState();
}

class _DeleteAnimatedAlertState extends State<DeleteAnimatedAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.3).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
          scale: _scaleAnimation,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.redAccent, fontWeightDelta: 3),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Divider(
                      color: Theme.of(context).cardColor,
                    ),
                    deleteItems(
                      context: context,
                      title: "Delete For Everyone",
                      onTap: () {},
                    ),
                    Divider(
                      color: Theme.of(context).cardColor,
                    ),
                    deleteItems(
                      context: context,
                      title: "Delete For Me",
                      onTap: () {},
                    ),
                    Divider(
                      color: Theme.of(context).cardColor,
                    ),
                    deleteItems(
                      context: context,
                      title: "Cancel",
                      onTap: () async {
                        await _controller.reverse();
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    Divider(
                      color: Theme.of(context).cardColor,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

Widget deleteItems(
    {required BuildContext context,
    required String title,
    required Function onTap}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(fontWeightDelta: 3),
          ),
        ),
      ],
    ),
  );
}
