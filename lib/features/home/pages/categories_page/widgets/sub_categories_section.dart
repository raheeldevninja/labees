import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/products_screen.dart';
import 'package:provider/provider.dart';


/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: SubCategoriesSection
*/

class SubCategoriesSection extends StatelessWidget {
  const SubCategoriesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.lightGrey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListView.builder(
        controller: ScrollController(),
        //itemCount: subCategories.length,
        itemCount: homeProvider.childsList!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity:
            const VisualDensity(vertical: -4),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsScreen(id: homeProvider.childsList![index].id!),
                ),
              );

            },
            title: Text(
              homeProvider.childsList![index].name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: homeProvider
                    .childsList![index].isSelected
                    ? AppColors.primaryColor
                    : AppColors.lightGrey,
              ),
            ),

          );
        },
      ),
    );
  }
}
