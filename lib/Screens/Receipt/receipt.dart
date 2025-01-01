import 'package:amenda_cuts/Common/Widget/Button/user_button_border.dart';
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
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text("E-Receipt",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: mWidth * 90,
                        child: Card(
                          color: Theme.of(context).cardColor,
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
                                  Text("Pending Payment",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      return Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                            (constraints.constrainWidth() / 20)
                                                .floor(),
                                            (index) => Text(
                                                  ' -',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge!
                                                      .apply(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.9)),
                                                )),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  receiptTile(context, 'Amount', '200/='),
                                  receiptTile(
                                      context, 'From', 'Isaiah Wainaina'),
                                  receiptTile(context, 'To', 'Amenda Gerishom'),
                                  receiptTile(
                                      context, 'Transaction Id', 'XADVBA24'),
                                  receiptTile(context, 'Date', '12/04/2024'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  userButtonOutline(
                                    width: double.infinity,
                                    name: 'Download',
                                    onTap: () {},
                                    context: context,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: mHeight * 15,
                      right: 12,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: mHeight * 15,
                      left: 14,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  ListTile receiptTile(BuildContext context, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium!.apply(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white38
                : Colors.black45),
      ),
    );
  }
}
