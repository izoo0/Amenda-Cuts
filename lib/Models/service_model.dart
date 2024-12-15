import 'package:amenda_cuts/Constants/FirebaseConstants/firebase_service_constants.dart';

class ServiceModel {
  final String documentId;
  final String serviceName;
  final String serviceImage;
  final num serviceRatings;
  final String servicePrice;
  final String discreption;
  final List<String> favorite;
  final bool isDeleted;
  final String? bookingDate;
  final String? timeRange;
  final String? location;
  ServiceModel(
      {required this.serviceName,
      required this.serviceImage,
      required this.serviceRatings,
      required this.servicePrice,
      required this.discreption,
      required this.favorite,
      required this.documentId,
      this.bookingDate,
      this.location,
      this.timeRange,
      required this.isDeleted});
  @override
  String toString() =>
      'ServiceModel(serviceName: $serviceName, serviceImage: $serviceImage, serviceRatings: $serviceRatings, servicePrice: $servicePrice, discreption: $discreption, favorite: $favorite, isDeleted: $isDeleted)';
  factory ServiceModel.fromFirebase(
      {required Map<String, dynamic> serviceData, documentId}) {
    List<String> favoriteList = [];
    var newFavorite = serviceData[FirebaseServiceConstants.serviceFavorite];
    if (newFavorite != null && newFavorite is List) {
      newFavorite.forEach((id) {
        favoriteList.add(id);
      });
    }

    return ServiceModel(
      serviceName: serviceData[FirebaseServiceConstants.serviceName],
      serviceImage: serviceData[FirebaseServiceConstants.serviceReserveDate],
      serviceRatings: serviceData[FirebaseServiceConstants.serviceRatings],
      servicePrice: serviceData[FirebaseServiceConstants.servicePrice],
      discreption: serviceData[FirebaseServiceConstants.serviceDescription],
      favorite: favoriteList,
      isDeleted: serviceData[FirebaseServiceConstants.serviceisDeleted],
      documentId: documentId,
      location: serviceData[FirebaseServiceConstants.serviceLocation] ?? '',
      bookingDate:
          serviceData[FirebaseServiceConstants.serviceReserveDate] ?? '',
      timeRange: serviceData[FirebaseServiceConstants.serviceTimeRange] ?? '',
    );
  }
}
