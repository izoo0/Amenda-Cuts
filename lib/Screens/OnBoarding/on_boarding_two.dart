import 'package:amenda_cuts/Auth/SignIn/sign_in.dart';
import 'package:amenda_cuts/Auth/SignUp/sign_up.dart';
import 'package:amenda_cuts/Common/Widget/Button/button.dart';
import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingTwo extends StatefulWidget {
  const OnBoardingTwo({super.key});

  @override
  State<OnBoardingTwo> createState() => _OnBoardingTwoState();
}

class _OnBoardingTwoState extends State<OnBoardingTwo> {
  String? svgString;

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  Future<void> _loadSvg() async {
    String rawSvg =
        await rootBundle.loadString('assets/Illustrations/booking.svg');
    setState(() {
      svgString = rawSvg;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  height: 50,
                ),
                button(
                  context: context,
                  onTap: () {},
                  text: '  Continue With Google',
                  color: Theme.of(context).cardColor,
                  image: const Image(
                    image: AssetImage(
                      'assets/Images/g.png',
                    ),
                    width: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                button(
                  context: context,
                  onTap: () {},
                  text: '  Continue With Facebook',
                  color: Theme.of(context).cardColor,
                  image: const Image(
                    image: AssetImage(
                      'assets/Images/f.png',
                    ),
                    width: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                button(
                  context: context,
                  onTap: () {},
                  text: '  Continue With Twitter',
                  color: Theme.of(context).cardColor,
                  image: const Image(
                    image: AssetImage(
                      'assets/Images/x.png',
                    ),
                    width: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                button(
                  context: context,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const SignIn()));
                  },
                  text: 'Sign In With Password',
                  color: ColorConstants.appColor,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You Do Not Have An Account ?",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: ColorConstants.appColor,
                          ),
                        ),
                      )
                    ])
              ],
            ),
          )),
    );
  }
}
