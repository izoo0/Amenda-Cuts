import 'package:flutter/material.dart';

import '../../../../Common/Widget/Containers/category_container.dart';
import '../../../../Models/category_model.dart';

Container categorySection({required double mHeight}) {
  return Container(
    height: mHeight * 8,
    constraints: BoxConstraints(minHeight: mHeight * 8),
    child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cats = categories[index];
          return categoryContainer(
              context: context,
              path: cats.imagePath,
              category: cats.categoryName);
        }),
  );
}
