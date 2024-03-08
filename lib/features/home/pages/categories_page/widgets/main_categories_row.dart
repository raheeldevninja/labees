import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 21 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Main Categories Row
*/

class MainCategoriesRow extends StatefulWidget {
  const MainCategoriesRow({Key? key}) : super(key: key);

  @override
  State<MainCategoriesRow> createState() => _MainCategoriesRowState();
}

class _MainCategoriesRowState extends State<MainCategoriesRow> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: TextButton(
            onPressed: () {
              homeProvider
                  .setCategoryChildren(homeProvider.categories![0].childes!);

              homeProvider.setMainCategory(homeProvider.categories![0].name!);

              ///set sub sub childs
              homeProvider.setChildList(
                  homeProvider.getCategoryChildren![0].childes!,
                  homeProvider.getCategoryChildren![0].parentId!,
                  homeProvider.getCategoryChildren![0].name!);

              for (int i = 0;
                  i < homeProvider.getCategoryChildren!.length;
                  i++) {
                homeProvider.getCategoryChildren![i] = homeProvider
                    .getCategoryChildren![i]
                    .copyWith(isSelected: false);
              }

              homeProvider.getCategoryChildren![0] = homeProvider
                  .getCategoryChildren![0]
                  .copyWith(isSelected: true);
            },
            child: Text(
              homeProvider.categories![0].name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: homeProvider.getMainCategory ==
                        homeProvider.categories![0].name!
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: homeProvider.getMainCategory ==
                        homeProvider.categories![0].name!
                    ? AppColors.primaryColor
                    : AppColors.lightGrey,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              homeProvider
                  .setCategoryChildren(homeProvider.categories![1].childes!);

              homeProvider.setMainCategory(homeProvider.categories![1].name!);

              ///set sub-sub-childs
              homeProvider.setChildList(
                  homeProvider.getCategoryChildren![0].childes!,
                  homeProvider.getCategoryChildren![0].parentId!,
                  homeProvider.getCategoryChildren![0].name!);

              for (int i = 0;
                  i < homeProvider.getCategoryChildren!.length;
                  i++) {
                homeProvider.getCategoryChildren![i] = homeProvider
                    .getCategoryChildren![i]
                    .copyWith(isSelected: false);
              }

              homeProvider.getCategoryChildren![0] = homeProvider
                  .getCategoryChildren![0]
                  .copyWith(isSelected: true);
            },
            child: Text(
              homeProvider.categories![1].name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: homeProvider.getMainCategory ==
                        homeProvider.categories![1].name!
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: homeProvider.getMainCategory ==
                        homeProvider.categories![1].name!
                    ? AppColors.primaryColor
                    : AppColors.lightGrey,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              homeProvider
                  .setCategoryChildren(homeProvider.categories![2].childes!);

              homeProvider.setMainCategory(homeProvider.categories![2].name!);

              ///set sub sub childs
              homeProvider.setChildList(
                  homeProvider.getCategoryChildren![0].childes!,
                  homeProvider.getCategoryChildren![0].parentId!,
                  homeProvider.getCategoryChildren![0].name!);

              for (int i = 0;
                  i < homeProvider.getCategoryChildren!.length;
                  i++) {
                homeProvider.getCategoryChildren![i] = homeProvider
                    .getCategoryChildren![i]
                    .copyWith(isSelected: false);
              }

              homeProvider.getCategoryChildren![0] = homeProvider
                  .getCategoryChildren![0]
                  .copyWith(isSelected: true);
            },
            child: Text(
              homeProvider.categories![2].name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: homeProvider.getMainCategory ==
                        homeProvider.categories![2].name!
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: homeProvider.getMainCategory ==
                        homeProvider.categories![2].name!
                    ? AppColors.primaryColor
                    : AppColors.lightGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
