import 'package:amenda_cuts/Auth/SignIn/sign_in.dart';
import 'package:amenda_cuts/Auth/SignUp/sign_up.dart';
import 'package:amenda_cuts/Common/Widget/Button/button.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardigTwo extends StatefulWidget {
  const OnBoardigTwo({super.key});

  @override
  State<OnBoardigTwo> createState() => _OnBoardigTwoState();
}

class _OnBoardigTwoState extends State<OnBoardigTwo> {
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
      color: ColorConstants.appBackground,
      child: Scaffold(
          backgroundColor: ColorConstants.appBackground,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/Logo/logo.png'),
                  width: mWidth * 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                button(
                  onTap: () {},
                  text: '  Continue With Google',
                  color: ColorConstants.blackBackground,
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
                  onTap: () {},
                  text: '  Continue With Facebook',
                  color: ColorConstants.blackBackground,
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
                  onTap: () {},
                  text: '  Continue With Twitter',
                  color: ColorConstants.blackBackground,
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
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: ColorConstants.blackBackground,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or",
                        style: TextStyle(color: ColorConstants.appTextColor),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: ColorConstants.blackBackground,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                button(
                  onTap: () {},
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
                      const Text(
                        "You Do Not Have An Account ?",
                        style: TextStyle(color: ColorConstants.appTextColor),
                      ),
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
