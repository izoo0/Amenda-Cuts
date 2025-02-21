import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../Common/Widget/BottomSheet/bottom_sheet.dart';
import '../../../../Common/Widget/Preloader/preloader.dart';
import '../../../../Functions/APIS/apis.dart';
import '../../../../Models/service_model.dart';
import '../favorite/favorite.dart';
import '../service/single_service_screen.dart';

Widget categoryDataSection(
    {required double mHeight,
    required String cate,
    required double mWidth,
    required BuildContext context}) {
  Apis instance = Apis.instance;

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(),
      Text(
        cate,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(
        height: 6,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: mWidth * 100,
          height: mHeight * 18,
          constraints: BoxConstraints(
            minHeight: mHeight * 18,
            minWidth: mWidth * 100,
          ),
          child: StreamBuilder<List<ServiceModel>>(
              stream: instance.fetchServices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final service = snapshot.data!;
                  List<ServiceModel> sectionService = service
                      .where((vice) => vice.serviceCategory == cate)
                      .toList();
                  sectionService.shuffle(Random());
                  final finalList = sectionService.take(8).toList();
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: preloader(20.0, context));
                    default:
                      return Center(
                        child: ListView.builder(
                            shrinkWrap: false,
                            itemCount: finalList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final data = finalList[index];
                              bool favorite = false;
                              final documentId = data.documentId;
                              var favorites =
                                  data.favorite.contains(instance.user?.uid);
                              if (favorites) {
                                favorite = true;
                              }
                              bool isDeleted = data.isDeleted;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  height: mHeight * 20,
                                  width: mWidth * 90,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 4),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: CachedNetworkImage(
                                              imageUrl: data.serviceImage,
                                              width: mWidth * 40,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data.serviceName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              data.serviceCategory,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'Ksh ${data.servicePrice}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .apply(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(data.description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    bottomSheet(
                                                        context: context,
                                                        height: mHeight * 28,
                                                        child: favoriteWidget(
                                                          context: context,
                                                          isFavorite: favorite,
                                                          image:
                                                              data.serviceImage,
                                                          description:
                                                              data.description,
                                                          serviceName:
                                                              data.serviceName,
                                                          price:
                                                              data.servicePrice,
                                                          onTap: () async {
                                                            await instance
                                                                .userFavorite(
                                                                    favorite,
                                                                    data
                                                                        .documentId,
                                                                    instance
                                                                        .user!
                                                                        .uid);

                                                            if (context
                                                                .mounted) {
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                        ));
                                                  },
                                                  child: Icon(
                                                    !favorite
                                                        ? Iconsax.archive_add
                                                        : Iconsax.archive_1,
                                                    color: !favorite
                                                        ? Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Colors.black
                                                            : Colors.white
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Expanded(
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SingleServiceScreen(
                                                                          serviceModel:
                                                                              data,
                                                                        )));
                                                      },
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4))),
                                                      child: Text(
                                                        "Book Now",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .apply(
                                                                color: Colors
                                                                    .black),
                                                      )),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                  }
                } else {
                  return const Text("No data available");
                }
              }),
        ),
      ),
    ],
  );
}
