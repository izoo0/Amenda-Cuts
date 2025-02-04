import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/order_model.dart';
import 'package:amenda_cuts/Models/service_model.dart';

Future<List<OrderModel>> getSingleService({
  required ServiceModel serviceModel,
  required Future<OrderModel> orderModel,
}) async {
  OrderModel order = await orderModel;
  Apis instance = Apis.instance;
  bool isFavorite = serviceModel.favorite.contains(instance.user?.uid);
  return [
    OrderModel(
        timestamp: order.timestamp,
        serviceId: order.serviceId,
        status: order.status,
        serviceModel: serviceModel,
        remindMe: order.remindMe,
        orderId: order.orderId,
        time: order.time,
        date: order.date,
        location: order.location,
        expertId: order.expertId,
        userId: order.userId)
  ];
}
