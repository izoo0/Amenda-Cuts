import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  PackageInfo packageInfo = PackageInfo(
      appName: "Unknown",
      packageName: "Unknown",
      version: "Unknown",
      buildNumber: "Unknown");

  @override
  void initState() {
    super.initState();
    getPackageDetails();
  }

  Future<void> getPackageDetails() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.blockSizeWidth!;
    return NewAppBackground(
        child: Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          "About App",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Stack(
        children: [
          Image(
            image: AssetImage(Theme.of(context).brightness == Brightness.dark
                ? "assets/Images/bg1.jpg"
                : "assets/Images/bg.jpg"),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  packageInfo.appName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: Theme.of(context).primaryColor),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: AssetImage(
                        Theme.of(context).brightness == Brightness.dark
                            ? "assets/Logo/logo.png"
                            : "assets/Logo/logo_light.jpg"),
                    width: width * 30,
                  ),
                ),
                Text(
                  packageInfo.version,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
