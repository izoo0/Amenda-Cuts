import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:flutter/material.dart';

class CreateService extends StatefulWidget {
  final List<ServiceModel>? serviceModel;
  const CreateService({super.key, this.serviceModel});

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ));
  }
}
