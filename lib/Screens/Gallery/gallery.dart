import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:flutter/material.dart';

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: StreamBuilder<List<ServiceModel>>(
                stream: instance.fetchServices(),
                builder: (context, snapshot) {
                  final service = snapshot.data;
                  if (snapshot.hasData && snapshot.data != null) {
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 10, // Vertical spacing between items
                          crossAxisSpacing:
                              10, // Horizontal spacing between items
                        ),
                        itemCount: service?.length,
                        itemBuilder: (context, index) {
                          final image = service?[index];
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
                              child: Image(
                                image: NetworkImage(image?.serviceImage ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
