import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final DateTime timestamp;
  final ServiceModel service;
  final UsersModel user;
  final String status;

  OrderModel({
    required this.timestamp,
    required this.service,
    required this.user,
    required this.status,
  });

  factory OrderModel.fromFirebase({
    required Map<String, dynamic> orderModel,
    required service,
    required user,
  }) {
    DateTime bookingTime = DateTime(1950);
    var newTime = orderModel['timestamp'];
    if (newTime != null && newTime is Timestamp) {
      bookingTime = newTime.toDate();
    }

    return OrderModel(
      timestamp: bookingTime,
      service: service,
      user: user,
      status: orderModel['status'],
    );
  }
}
