import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../Common/Widget/BottomSheet/bottom_sheet.dart';
import '../../../../Common/Widget/Containers/service_container.dart';
import '../../../../Common/Widget/Preloader/preloader.dart';
import '../../../../Functions/APIS/apis.dart';
import '../../../../Models/service_model.dart';
import '../favorite/favorite.dart';
import '../service/single_service_screen.dart';

Widget allServiceSection({required double mHeight}) {
  Apis instance = Apis.instance;

  return StreamBuilder<List<ServiceModel>>(
      stream: instance.fetchServices(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final service = snapshot.data!;
          service.shuffle(Random());
          final finalList = service.take(8).toList();
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: preloader(20.0, context));
            default:
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: mHeight / 17.3,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  itemCount: finalList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = service[index];

                    bool favorite = false;
                    final documentId = data.documentId;
                    var favorites = data.favorite.contains(instance.user?.uid);
                    if (favorites) {
                      favorite = true;
                    }
                    bool isDeleted = data.isDeleted;
                    return serviceContainer(
                      image: data.serviceImage,
                      serviceName: data.serviceName,
                      description: data.description,
                      amount: data.servicePrice,
                      onTap: () {
                        bottomSheet(
                            context: context,
                            height: mHeight * 20,
                            child: favoriteWidget(
                              context: context,
                              isFavorite: favorite,
                              image: data.serviceImage,
                              description: data.description,
                              serviceName: data.serviceName,
                              price: data.servicePrice,
                              onTap: () async {
                                await instance.userFavorite(favorite,
                                    data.documentId, instance.user!.uid);

                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                            ));
                      },
                      isFavorite: favorites,
                      onTapBook: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SingleServiceScreen(
                                  serviceModel: data,
                                )));
                      },
                      context: context,
                    );
                  });
          }
        } else {
          return const Text("No data available");
        }
      });
}
