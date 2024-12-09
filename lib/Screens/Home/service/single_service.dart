import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:flutter/material.dart';

class SingleService extends StatefulWidget {
  const SingleService({super.key});

  @override
  State<SingleService> createState() => _SingleServiceState();
}

class _SingleServiceState extends State<SingleService> {
  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
        child: Scaffold(
      body: Container(),
    ));
  }
}
