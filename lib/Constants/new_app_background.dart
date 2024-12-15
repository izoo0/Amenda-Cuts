import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsBackground extends StatefulWidget {
  const SettingsBackground({super.key, required this.child});
  final Widget child;

  @override
  State<SettingsBackground> createState() => _SettingsBackgroundState();
}

class _SettingsBackgroundState extends State<SettingsBackground> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorConstants.appBackground,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xfff5f5f5)),
        child: widget.child);
  }
}

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
                  ? Brightness.dark
                  : Brightness.light,
          systemNavigationBarColor: Colors.transparent,
        ),
        child: widget.child);
  }
}
