import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAppBackground extends StatefulWidget {
  const NewAppBackground({super.key, this.color, required this.child});
  final Widget child;
  final Color? color;

  @override
  State<NewAppBackground> createState() => _NewAppBackgroundState();
}

class _NewAppBackgroundState extends State<NewAppBackground> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
          systemNavigationBarColor: Theme.of(context).cardColor,
        ),
        child: widget.child);
  }
}
