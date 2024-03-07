import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/home/pages/categories_page/widgets/category_children.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:provider/provider.dart';


/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: CategoryChildrenSection
*/


class CategoryChildrenSectionBackup extends StatelessWidget {
  const CategoryChildrenSectionBackup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);

    return SizedBox(
      //width: 110,
      child: RawScrollbar(
        //thumbVisibility: true,
        thumbColor: AppColors.primaryColor,
        thickness: 2,
        child: ListView.builder(
          shrinkWrap: true,

          itemCount: homeProvider.getCategoryChildren!.length,
          padding: const EdgeInsets.all(4),
          itemBuilder: (context, index) {

            return InkWell(
              onTap: () {

                // print('clicked');
                //
                // for (int i = 0; i < homeProvider.getCategoryChildren!.length; i++) {
                //
                //   if(i != index) {
                //     homeProvider.getCategoryChildren![i] = homeProvider.getCategoryChildren![i].copyWith(isSelected: false);
                //   }
                //
                // }
                //
                // homeProvider.getCategoryChildren![index] = homeProvider.getCategoryChildren![index].copyWith(isSelected: true);
                //
                // print('CategoryChildrenSectionBackup: ${homeProvider.getCategoryChildren![index].name}');
                //
                // //set sub sub childs
                // homeProvider.setChildList(homeProvider.getCategoryChildren![index].childes!, homeProvider.getCategoryChildren![index].name!);
                //
                // homeProvider.setSelectedCategoryIndex(index);

              },
              child: CategoryChildren(categoryChild:  homeProvider.getCategoryChildren![index], index: index,),
            );
          },
        ),
      ),
    );
  }
}

