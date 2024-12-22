import 'package:amenda_cuts/Constants/FirebaseConstants/firebase_service_constants.dart';

class ServiceModel {
  final String documentId;
  final String serviceName;
  final String serviceImage;
  final num serviceRatings;
  final String servicePrice;
  final String description;
  final List<String> favorite;
  final bool isDeleted;
  ServiceModel(
      {required this.serviceName,
      required this.serviceImage,
      required this.serviceRatings,
      required this.servicePrice,
      required this.description,
      required this.favorite,
      required this.documentId,
      required this.isDeleted});
  @override
  String toString() =>
      'ServiceModel(serviceName: $serviceName, serviceImage: $serviceImage, serviceRatings: $serviceRatings, servicePrice: $servicePrice, description: $description, favorite: $favorite, isDeleted: $isDeleted)';
  factory ServiceModel.fromFirebase(
      {required Map<String, dynamic> serviceData, required documentId}) {
    List<String> favoriteList = [];
    var newFavorite = serviceData[FirebaseServiceConstants.serviceFavorite];
    if (newFavorite != null && newFavorite is List) {
      for (var id in newFavorite) {
        favoriteList.add(id);
      }
    }

    return ServiceModel(
      serviceName: serviceData[FirebaseServiceConstants.serviceName],
      serviceImage: serviceData[FirebaseServiceConstants.serviceImage],
      serviceRatings: serviceData[FirebaseServiceConstants.serviceRatings],
      servicePrice: serviceData[FirebaseServiceConstants.servicePrice],
      description: serviceData[FirebaseServiceConstants.serviceDescription],
      favorite: favoriteList,
      isDeleted: serviceData[FirebaseServiceConstants.serviceIsDeleted],
      documentId: documentId ?? '',
    );
  }
}
