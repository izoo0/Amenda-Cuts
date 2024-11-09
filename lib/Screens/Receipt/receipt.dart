import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;
    double mHeight = SizeConfig.blockSizeHeight!;
    return NewAppBackground(
        color: ColorConstants.appBackground,
        child: Scaffold(
            backgroundColor: ColorConstants.appBackground,
            appBar: AppBar(
              backgroundColor: ColorConstants.appBackground,
              title: const Text(
                "E-Receipt",
                style: TextStyle(color: ColorConstants.appTextColor),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Card(
                  color: ColorConstants.blackBackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            child: Stack(
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 90,
                                    maxWidth: 90,
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomLeft,
                                          stops: const [
                                            0.0,
                                            1.0
                                          ],
                                          colors: [
                                            ColorConstants.appColor
                                                .withOpacity(0.4),
                                            ColorConstants.appColor
                                                .withOpacity(0.2)
                                          ])),
                                ),
                                Positioned(
                                  top: 18,
                                  left: 24,
                                  child: Container(
                                    width: 40,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.redAccent,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Iconsax.clock,
                                      color: ColorConstants.appTextColor
                                          .withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "Pending Payment",
                            style: TextStyle(
                                color: ColorConstants.appTextColor,
                                fontSize: 24),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              print('${constraints.constrainWidth()}');
                              return Flex(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                direction: Axis.horizontal,
                                children: List.generate(
                                    (constraints.constrainWidth() / 4).floor(),
                                    (index) => Text(
                                          ' -',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: ColorConstants.appTextColor
                                                  .withOpacity(0.3)),
                                        )),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
