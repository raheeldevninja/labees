import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/category_child.dart';

/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: CategoryChildren
*/

class CategoryChildren extends StatelessWidget {
  const CategoryChildren({
    super.key,
    required this.categoryChild,
  });

  final CategoryChild categoryChild;

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: categoryChild.isSelected!
            ? AppColors.primaryColor
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl:
            '${APIs.imageBaseURL}${APIs.categoryImages}${categoryChild.icon!}',
            width: 40,
            height: 40,
            color: categoryChild.isSelected! ? Colors.white: AppColors.primaryColor,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            categoryChild.name!,
            style: TextStyle(
              fontSize: 12,
              color: categoryChild
                  .isSelected!
                  ? Colors.white
                  : AppColors.lightGrey,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}