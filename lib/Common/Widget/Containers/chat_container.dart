import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:flutter/material.dart';

Widget chatContainer({required BuildContext context, required Function onTap}) {
  SizeConfig().init(context);
  double width = SizeConfig.blockSizeWidth!;
  return GestureDetector(
    onTap: () {
      onTap();
    },
    onDoubleTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                  child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 72,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Joseph Norge",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            "Timestamps: These indicate the date and time when a message was sent or received.",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "12:00",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadiusDirectional.circular(12)),
                            child: Text(
                              "2",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    ),
  );
}
