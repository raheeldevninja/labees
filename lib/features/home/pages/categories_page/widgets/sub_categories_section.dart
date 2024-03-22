import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/childes.dart';
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
    required this.childsList,
    Key? key,
  }) : super(key: key);

  final List<Childes> childsList;

/*  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        controller: ScrollController(),
        itemCount: homeProvider.childsList!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          print(
              'SubCategoriesSection: ${homeProvider.childsList![index].name} ${homeProvider.childsList![index].id}');

          return ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            onTap: () {
              //int? id = index == 0 ? homeProvider.childsList![index].parentId : homeProvider.childsList![index].id!;
              int? id = homeProvider.childsList![index].id!;

              print(
                  'SubCategoriesSection: ${homeProvider.childsList![index].name} $id');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsScreen(
                      id: homeProvider.childsList![index].id!,
                      title: homeProvider.childsList![index].name!),
                  //builder: (context) => ProductsScreen(id: id!, title: homeProvider.childsList![index].name!),
                ),
              );
            },
            title: Text(
              homeProvider.childsList![index].name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: homeProvider.childsList![index].isSelected
                    ? AppColors.primaryColor
                    : AppColors.lightGrey,
              ),
            ),
            trailing: SvgPicture.network(
              width: 30,
                height: 30,
                '${APIs.imageBaseURL}${APIs.categoryImages}${homeProvider.childsList![index].icon ?? ''}'),
          );
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        controller: ScrollController(),
        itemCount: childsList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {


          return ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsScreen(
                      id: childsList[index].id!,
                      title: childsList[index].name!),
                  //builder: (context) => ProductsScreen(id: id!, title: homeProvider.childsList![index].name!),
                ),
              );
            },
            title: Text(
              childsList[index].name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: childsList[index].isSelected
                    ? AppColors.primaryColor
                    : AppColors.lightGrey,
              ),
            ),
            trailing: SvgPicture.network(
                width: 30,
                height: 30,
                '${APIs.imageBaseURL}${APIs.categoryImages}${childsList[index].icon ?? ''}'),
          );
        },
      ),
    );
  }

}
