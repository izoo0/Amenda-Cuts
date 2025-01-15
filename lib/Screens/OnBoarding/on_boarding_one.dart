import 'package:amenda_cuts/Common/Constants/color_constants.dart';
import 'package:flutter/material.dart';

class OnBoardingOne extends StatelessWidget {
  const OnBoardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Images/on.jpg'), fit: BoxFit.cover),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.bottomCenter, colors: [
              Colors.black,
              Colors.black45,
            ])),
          ),
          const Positioned(
            bottom: 80,
            left: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to 👋',
                  style: TextStyle(
                    color: ColorConstants.appTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Amenda Cuts',
                  style: TextStyle(
                    color: ColorConstants.appColor,
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    'Where we embrace new techniques & trends \n to stay at the forefront of the industry',
                    style: TextStyle(
                      color: Color.fromARGB(115, 245, 245, 245),
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 2.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstants.appColor),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorConstants.appTextColor,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
