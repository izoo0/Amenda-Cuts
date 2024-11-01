import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ServiceController(
    {required ServiceModel serviceModel, required BuildContext context}) {
  bool isFavorite = false;
  List<String> favorite = [];

  if ((serviceModel.favorite).isNotEmpty) {
    favorite = serviceModel.favorite;
    if (favorite.contains(Apis.user?.uid)) isFavorite = true;
  }
}

getSingleService(
    {required BuildContext context, required ServiceModel serviceModel}) async {
  service = await ServiceController(
    serviceModel: serviceModel,
    context: context,
  );
  return service;
}
