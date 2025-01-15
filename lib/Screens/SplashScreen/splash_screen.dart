import 'package:amenda_cuts/Common/Widget/Navigation/navigation_bar.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/APIS/apis.dart';
import 'package:amenda_cuts/Screens/OnBoarding/on_boarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    Future.delayed(const Duration(seconds: 6), () {
      // ignore: unnecessary_null_comparison
      if (Apis.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const BottomNavigator()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnBoarding()));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
        child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: Theme.of(context).brightness == Brightness.dark
                      ? const AssetImage('assets/Logo/logo.png')
                      : const AssetImage('assets/Logo/logo_light.jpg'),
                  width: mWidth * 40,
                  fit: BoxFit.cover,
                ),
              ),
              preloader(mWidth * 7, context)
            ],
          ),
        ),
      ),
    ));
  }
}
