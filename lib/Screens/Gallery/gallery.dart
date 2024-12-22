import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final Apis instance = Apis.instance;
  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Our Gallery',
              style: Theme.of(context).textTheme.displaySmall),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: StreamBuilder<List<ServiceModel>>(
              stream: instance.fetchServices(),
              builder: (context, snapshot) {
                final service = snapshot.data;
                if (snapshot.hasData && snapshot.data != null) {
                  return GridView.custom(
                      scrollDirection: Axis.vertical,
                      semanticChildCount: service?.length ?? 0,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: [
                          const QuiltedGridTile(2, 2),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 2),
                        ],
                      ),
                      childrenDelegate:
                          SliverChildBuilderDelegate((context, index) {
                        if (service == null || index >= service.length) {
                          return const SizedBox.shrink();
                        }
                        final image = service[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: ColorConstants.appColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl: image.serviceImage,
                                fit: BoxFit.cover,
                              )),
                        );
                      }));
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ),
      ),
    );
  }
}
