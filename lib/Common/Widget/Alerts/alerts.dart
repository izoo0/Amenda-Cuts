import 'package:flutter/material.dart';

class AnimatedAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final Icon icon;
  const AnimatedAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  State<AnimatedAlertDialog> createState() => _AnimatedAlertDialogState();
}

class _AnimatedAlertDialogState extends State<AnimatedAlertDialog>
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          backgroundColor: Theme.of(context).cardColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 2,
              ),
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.icon,
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.content,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                    onPressed: () {
                      // Reverse the animation and close the dialog
                      _controller.reverse();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Close",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
