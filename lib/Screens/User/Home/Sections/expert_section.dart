import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../Common/Widget/Containers/slider_container.dart';
import '../../../../Common/Widget/Rating/rating_widget.dart';

Widget expertSection({required List experts}) {
  return ListView.builder(
      itemCount: experts.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final data = experts[index];

        final intRating = data.rating ?? 0;
        double rating = intRating.toDouble();
        String ratings = intRating.toString();
        return sliderContainer(
          context: context,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: data.profile != null && (data.profile!.length) > 2
                      ? CachedNetworkImage(
                          imageUrl: data.profile ?? '',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : Image(
                          image: AssetImage(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 'assets/Logo/logo.png'
                                  : 'assets/Logo/logo_light.jpg'),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.name ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "Hair Cut Specialist",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ratingBar(
                      context: context,
                      initialRating: rating,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(ratings)
                  ],
                )
              ],
            ),
          ),
        );
      });
}
