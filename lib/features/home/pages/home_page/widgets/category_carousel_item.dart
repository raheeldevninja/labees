import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/category_child.dart';


/*
*  Date 12 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: CategoryCarouselItem
*/


class CategoryCarouselItem extends StatelessWidget {
  const CategoryCarouselItem({required this.item, Key? key}) : super(key: key);

  final CategoryChild item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54.withOpacity(0.1),
              blurRadius: 15.0,
              offset: const Offset(0.0, 0.75))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            width: 50,
            height: 50,
            imageUrl:
            '${APIs.imageBaseURL}${APIs.categoryImages}${item.icon!}',
            placeholder: (context, url) =>
            const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) =>
            const Icon(Icons.error),
          ),
          const SizedBox(height: 12),
          Text(
            item.name!,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
