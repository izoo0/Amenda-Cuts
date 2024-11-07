import 'package:amenda_cuts/Common/Widget/Button/user_button.dart';
import 'package:amenda_cuts/Common/Widget/Listtile/receipt_listtile.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BarcodeWidget(
                      width: mWidth * 85,
                      height: mHeight * 12,
                      data: '12344',
                      drawText: false,
                      style:
                          const TextStyle(color: ColorConstants.appTextColor),
                      color: ColorConstants.appTextColor.withOpacity(0.8),
                      barcode: Barcode.codabar(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: mWidth * 85,
                      decoration: BoxDecoration(
                        color: ColorConstants.appTextColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          receiptTile(
                              leading: "Barber Shop", trailling: "Amenda Cuts"),
                          receiptTile(
                              leading: "Address", trailling: "50200-Bungoma"),
                          receiptTile(leading: 'Name', trailling: 'John Doe'),
                          receiptTile(
                              leading: 'Phone', trailling: '+254 793783983'),
                          receiptTile(
                              leading: 'Booking Date', trailling: '1/2/2024'),
                          receiptTile(leading: 'Time', trailling: "04:52"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: mWidth * 85,
                      decoration: BoxDecoration(
                        color: ColorConstants.appTextColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          receiptTile(
                              leading: "Hair Cut", trailling: "ksh 200"),
                          receiptTile(
                              leading: "Half Black Color",
                              trailling: "ksh 300"),
                          receiptTile(leading: "Total", trailling: "Ksh 500"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Divider(
                              color:
                                  ColorConstants.appTextColor.withOpacity(0.2),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    userButtton(
                      width: mWidth * 85,
                      name: 'Download E-Receipt',
                      color: ColorConstants.appColor,
                      onTap: () {},
                    )
                  ],
                ),
              ),
            )));
  }
}
