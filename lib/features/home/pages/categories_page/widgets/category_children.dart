import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/category_child.dart';
import 'package:labees/features/home/pages/categories_page/widgets/sub_categories_section.dart';
import 'package:provider/provider.dart';

import '../../../view_model/home_provider.dart';

/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: CategoryChildren
*/

class CategoryChildren extends StatelessWidget {
  const CategoryChildren({
    super.key,
    required this.categoryChild,
    required this.index,
  });

  final CategoryChild categoryChild;
  final int index;

  @override
  Widget build(BuildContext context) {
    print(
        'categoryChild seleted: ${categoryChild.name} ${categoryChild.isSelected!}');

    final homeProvider = Provider.of<HomeProvider>(context);

    /*return Container(
      width: double.maxFinite,

      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              Text(
                categoryChild.name!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryColor,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.lightGrey),

              const Expanded(child: SizedBox()),

              CachedNetworkImage(
                imageUrl:
                '${APIs.imageBaseURL}${APIs.categoryImages}${categoryChild.icon!}',
                width: 40,
                height: 40,
                color: AppColors.primaryColor,
                fit: BoxFit.cover,
              ),


            ],
          ),

          //sub-sub categories

          categoryChild.isSelected!
              ?
          const SubCategoriesSection() : const SizedBox(),

        ],
      ),
    );*/

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
        onExpansionChanged: (value) {
          homeProvider.getCategoryChildren![index] = homeProvider
              .getCategoryChildren![index]
              .copyWith(isSelected: value);

          print(
              'CategoryChildrenSectionBackup: ${homeProvider.getCategoryChildren![index].name} ${homeProvider.getCategoryChildren![index].id!}');

          //set sub sub childs
          homeProvider.setChildList(
              homeProvider.getCategoryChildren![index].childes!,
              homeProvider.getCategoryChildren![index].id!,
              homeProvider.getCategoryChildren![index].name!,
          );

          //homeProvider.setSelectedCategoryIndex(index);
        },
        title: Row(
          children: [
            Text(
              categoryChild.name!,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.lightGrey),
          ],
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 0),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl:
                '${APIs.imageBaseURL}${APIs.categoryImages}${categoryChild.icon!}',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        children: [
          categoryChild.isSelected!
              ? SubCategoriesSection(childsList: homeProvider.getCategoryChildren![index].childes!)
              : const SizedBox(),
        ],
      ),
    );

    /*return Container(
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
    );*/
  }
}
