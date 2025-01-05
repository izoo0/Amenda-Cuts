import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Widget/Containers/admin_service_container.dart';
import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Screens/Admin/Service/create_service.dart';
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
            body: StreamBuilder(
                stream: instance.fetchServices(),
                builder: (context, snap) {
                  List<ServiceModel>? data = snap.data;
                  return GridView.builder(
                      itemCount: data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        return index == 0
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => CreateService(
                                                serviceModel: data,
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Theme.of(context).cardColor,
                                      border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).cardColor,
                                      )),
                                  child: const Center(
                                    child: Icon(
                                      Iconsax.add,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              )
                            : adminServiceContainer(
                                image:
                                    'https://plus.unsplash.com/premium_photo-1658506711778-d56cdeae1b9b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                serviceName: "Rasta",
                                description:
                                    "Aliquam a ante at nunc mattis viverra. Pellentesque rhoncus pharetra.",
                                amount: 'Ksh 200',
                                onTap: () {},
                                isFavorite: false,
                                onTapBook: () {},
                                context: context);
                      });
                })));
  }
}
