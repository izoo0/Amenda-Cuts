import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Widget/Containers/admin_service_container.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Screens/Admin/Service/create_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  Apis instance = Apis.instance;
  @override
  Widget build(BuildContext context) {
    return NewAppBackground(
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const BottomNavigator()));
                  },
                  icon: const Icon(Iconsax.home)),
              title: const Text("Services"),
            ),
            body: StreamBuilder<List<ServiceModel>>(
                stream: instance.fetchServices(),
                builder: (context, snap) {
                  if (snap.data != null) {
                    final data = snap.data!;
                    ServiceModel createData = ServiceModel(
                        serviceName: '',
                        serviceImage: '',
                        serviceRatings: 0,
                        imageId: '',
                        servicePrice: '',
                        description: '',
                        favorite: [],
                        documentId: '',
                        isDeleted: false,
                        serviceCategory: '');
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: GridView.builder(
                          itemCount: data.length + 1,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.66,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CreateService(
                                            serviceModel: createData,
                                          )));
                                },
                                child: DottedBorder(
                                  strokeWidth: 3,
                                  dashPattern: const [6, 4],
                                  color: Theme.of(context).primaryColor,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Iconsax.add,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            final serviceIndex = index - 1;
                            final details = data[serviceIndex];
                            return adminServiceContainer(
                                image: details.serviceImage,
                                serviceName: details.serviceName,
                                description: details.description,
                                amount: details.servicePrice,
                                onTapEdit: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CreateService(
                                            serviceModel: details,
                                          )));
                                },
                                isFavorite: false,
                                onTapDelete: () {},
                                context: context);
                          }),
                    );
                  } else {
                    return preloader(16.0, context);
                  }
                })));
  }
}
