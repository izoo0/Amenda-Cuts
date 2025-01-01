import 'package:amenda_cuts/Admin/Category/category.dart';
import 'package:amenda_cuts/Admin/Charts/charts.dart';
import 'package:amenda_cuts/Admin/Dashboard/dashboard.dart';
import 'package:amenda_cuts/Admin/Service/service.dart';
import 'package:amenda_cuts/Admin/Users/users.dart';
import 'package:amenda_cuts/Common/Widget/BottomSheet/bottom_sheet.dart';
import 'package:amenda_cuts/Common/Widget/Containers/category_container.dart';
import 'package:amenda_cuts/Common/Widget/Containers/service_container.dart';
import 'package:amenda_cuts/Common/Widget/Containers/slider_container.dart';
import 'package:amenda_cuts/Common/Widget/Drawer/drawer_items.dart';
import 'package:amenda_cuts/Common/Widget/Rating/rating_widget.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/service_model.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:amenda_cuts/Screens/Booking/booking.dart';
import 'package:amenda_cuts/Screens/Home/favorite/favorite.dart';
import 'package:amenda_cuts/Screens/Home/service/single_service_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController searchController;

  User? user = FirebaseAuth.instance.currentUser;
  final Apis instance = Apis.instance;
  bool isActive = false;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const Dashboard(),
    const Booking(),
    const Users(),
    const Service(),
    const Category(),
    const Charts(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Consumer<UserDetailsProvider>(
          builder: (context, userDetailsProvider, _) {
        UsersModel usersDetails = userDetailsProvider.usersModel;
        SizeConfig().init(context);
        double height = SizeConfig.blockSizeHeight!;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(0),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: height * 16,
                  color: Theme.of(context).cardColor,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  imageUrl: usersDetails.profile ?? '',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.sun_1))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    usersDetails.name ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    usersDetails.number ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isActive = !isActive;
                                  });
                                },
                                icon: Icon(
                                  !isActive
                                      ? Iconsax.arrow_down_1
                                      : Iconsax.arrow_up_2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                drawerItems(
                  context: context,
                  isActive: isActive,
                  userProfile: usersDetails.profile ?? '',
                  userName: usersDetails.name ?? '',
                )
              ],
            ),
          ),
          appBar: AppBar(
            toolbarHeight: 60,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: usersDetails.profile != null
                      ? CachedNetworkImage(
                          imageUrl: usersDetails.profile ?? '',
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        )
                      : const Image(
                          image: AssetImage('assets/Logo/logo.png'),
                          width: 45,
                        ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Amenda Cuts',
                  style: Theme.of(context).textTheme.displayMedium,
                )
              ],
            ),
            actions: [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Iconsax.notification_bing,
                  size: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Iconsax.archive_1,
                  size: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                  // print("Hello");
                },
                child: const Icon(Iconsax.menu),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Hello, ${usersDetails.name}👋",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  commonTextField(
                      context: context,
                      controller: searchController,
                      text: 'Search',
                      maxLines: 1,
                      icon: Iconsax.search_normal,
                      onChange: (value) {},
                      isPassword: false,
                      obscure: false,
                      isSearch: true,
                      validator: (value) {}),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: double.infinity,
                      maxHeight: 200,
                    ),
                    child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return sliderContainer(
                            context: context,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://plus.unsplash.com/premium_photo-1658506711778-d56cdeae1b9b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Gerishom Amenda",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Hair Cut Specialist",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ratingBar(
                                          context: context, initialRating: 4.2),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Text('4.2')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      categoryContainer(
                          context: context,
                          path: 'assets/Images/cu.png',
                          category: "Haircuts"),
                      categoryContainer(
                          context: context,
                          path: 'assets/Images/dr.png',
                          category: "Dreadlocks"),
                      categoryContainer(
                          context: context,
                          path: 'assets/Images/c.png',
                          category: "Hair Color"),
                      categoryContainer(
                          context: context,
                          path: 'assets/Images/p.png',
                          category: "Pedicure"),
                      categoryContainer(
                          context: context,
                          path: 'assets/Images/m.png',
                          category: "Manicure")
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(height: 2, color: Theme.of(context).cardColor),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<List<ServiceModel>>(
                      stream: instance.fetchServices(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final service = snapshot.data!;

                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.66,
                                      mainAxisSpacing: 6,
                                      crossAxisSpacing: 6,
                                      crossAxisCount: 2),
                              shrinkWrap: true,
                              itemCount: service.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = service[index];

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
                                        height: mHeight * 24,
                                        child: favoriteWidget(
                                            context: context,
                                            isFavorite: favorite,
                                            image: data.serviceImage,
                                            description: data.description,
                                            serviceName: data.serviceName,
                                            price: data.servicePrice,
                                            onTap: () {
                                              instance.userFavorite(favorite,
                                                  data.documentId, user!.uid);
                                              setState(() {});
                                              Navigator.pop(context);
                                            }));
                                  },
                                  isFavorite: favorites,
                                  onTapBook: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleServiceScreen(
                                                  serviceModel: data,
                                                )));
                                  },
                                  context: context,
                                );
                              });
                        } else {
                          return const Text("No data available");
                        }
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
