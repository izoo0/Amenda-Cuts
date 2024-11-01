class ServiceModel {
  final String serviceName;
  final String serviceImage;
  final num serviceRatings;
  final String servicePrice;
  final String discreption;
  final List<String> favorite;
  final bool isDeleted;
  ServiceModel(
      {required this.serviceName,
      required this.serviceImage,
      required this.serviceRatings,
      required this.servicePrice,
      required this.discreption,
      required this.favorite,
      required this.isDeleted});

  factory ServiceModel.fromFirebase(
      {required Map<String, dynamic> serviceData}) {
    List<String> favoriteList = [];
    var newFavorite = serviceData['favorite'];
    if (newFavorite != null && newFavorite is List) {
      newFavorite.forEach((id) {
        favoriteList.add(id);
      });
    }
    return ServiceModel(
      serviceName: serviceData['name'],
      serviceImage: serviceData['image'],
      serviceRatings: serviceData['ratings'],
      servicePrice: serviceData['price'],
      discreption: serviceData['description'],
      favorite: favoriteList,
      isDeleted: serviceData['isDeleted'],
    );
  }
}

List<ServiceModel> service = [];
