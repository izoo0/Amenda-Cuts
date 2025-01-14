import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Screens/User/Home/favorite/favorite.dart';
import 'package:amenda_cuts/Screens/User/Home/service/single_service_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Common/Widget/BottomSheet/bottom_sheet.dart';
import '../../../../Common/Widget/Containers/service_container.dart';
import '../../../../Common/Widget/Preloader/preloader.dart';

class CategoryService extends StatefulWidget {
  final String category;
  const CategoryService({super.key, required this.category});

  @override
  State<CategoryService> createState() => _CategoryServiceState();
}

class _CategoryServiceState extends State<CategoryService> {
  @override
  Widget build(BuildContext context) {
    final Apis instance = Apis.instance;
    User? user = FirebaseAuth.instance.currentUser;
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          widget.category == "View all" ? "Services" : widget.category,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: StreamBuilder<List<ServiceModel>>(
          stream: instance.fetchServices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final service = snapshot.data!;

              List<ServiceModel> finalList = [];
              if (widget.category == "View all") {
                finalList = service;
              } else {
                finalList = service
                    .where((services) =>
                        services.serviceCategory == widget.category)
                    .toList();
              }

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: preloader(20.0, context));
                default:
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: mHeight / 16.5,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                            crossAxisCount: 2),
                        shrinkWrap: true,
                        itemCount: finalList.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = finalList[index];

                          bool favorite = false;
                          final documentId = data.documentId;
                          var favorites =
                              data.favorite.contains(Apis.user?.uid);
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
                                      await instance.userFavorite(
                                          favorite, data.documentId, user!.uid);

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
                        }),
                  );
              }
            } else {
              return const Text("No data available");
            }
          }),
    ));
  }
}
