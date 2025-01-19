import 'package:amenda_cuts/Common/Widget/Drawer/drawer_items.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Models/other_users_model.dart';
import 'package:amenda_cuts/Models/users_model.dart';
import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:amenda_cuts/Screens/User/Home/Sections/all_service_section.dart';
import 'package:amenda_cuts/Screens/User/Home/Sections/button_section.dart';
import 'package:amenda_cuts/Screens/User/Home/Sections/category_data_section.dart';
import 'package:amenda_cuts/Screens/User/Home/Sections/category_section.dart';
import 'package:amenda_cuts/Screens/User/Home/Sections/expert_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  late TextEditingController searchController;

  final Apis instance = Apis.instance;
  bool isActive = false;
  bool isSearchEnabled = false;
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Consumer<OtherUserDetailsProvider>(
          builder: (context, otherUserProvider, _) {
        List<OtherUsersModel> expert = otherUserProvider.otherUserModel;
        List experts = expert.where((x) => x.isExpert == true).toList();
        return Consumer<UserDetailsProvider>(
            builder: (context, userDetailsProvider, _) {
          UsersModel usersDetails = userDetailsProvider.usersModel;
          SizeConfig().init(context);
          double height = SizeConfig.blockSizeHeight!;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            drawer: usersDetails.role == "admin"
                ? Drawer(
                    width: mWidth * 55,
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
                          color: Theme.of(context).cardColor,
                          child: SafeArea(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            usersDetails.name ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            usersDetails.number ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
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
                  )
                : null,
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
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage('assets/Logo/logo.png'),
                            width: 36,
                          ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Amenda Cuts',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              actions: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearchEnabled = !isSearchEnabled;
                    });
                  },
                  child: const Icon(
                    Iconsax.search_normal,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text("Hello, ${usersDetails.name}👋",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    if (isSearchEnabled)
                      const SizedBox(
                        height: 10,
                      ),
                    if (isSearchEnabled)
                      commonTextField(
                          isPrefix: true,
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
                        child: expertSection(experts: experts)),
                    const SizedBox(
                      height: 15,
                    ),
                    categorySection(mHeight: mHeight),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(height: 2, color: Theme.of(context).cardColor),
                    const SizedBox(
                      height: 8,
                    ),
                    categoryButton(
                      context: context,
                      mWidth: mWidth,
                      title: "View all",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    allServiceSection(mHeight: mHeight),
                    categoryDataSection(
                        context: context,
                        mHeight: mHeight,
                        mWidth: mWidth,
                        cate: "Haircuts"),
                    categoryDataSection(
                        context: context,
                        mHeight: mHeight,
                        mWidth: mWidth,
                        cate: "Dreadlocks"),
                    categoryDataSection(
                        context: context,
                        mHeight: mHeight,
                        mWidth: mWidth,
                        cate: "Hair Color"),
                    categoryDataSection(
                        context: context,
                        mHeight: mHeight,
                        mWidth: mWidth,
                        cate: "Pedicure"),
                    categoryDataSection(
                        context: context,
                        mHeight: mHeight,
                        mWidth: mWidth,
                        cate: "Manicure"),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
