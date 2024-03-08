import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/home/pages/categories_page/widgets/brand_grid_view_item.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: BrandsSection
*/

class BrandsSection extends StatelessWidget {
  const BrandsSection({
    Key? key,
    required this.selectedCategoryIndex,
  }) : super(key: key);

  final int selectedCategoryIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        homeProvider
                .getCategoryChildren![selectedCategoryIndex].brands!.isNotEmpty
            ? Text(
                l10n.brands,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),

        const SizedBox(
          height: 16,
        ),

        ///brands gridview
        GridView.builder(
          shrinkWrap: true,
          itemCount: homeProvider
              .getCategoryChildren![selectedCategoryIndex].brands!.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.3,
            crossAxisCount: 3,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
          ),
          itemBuilder: (BuildContext context, int brandIndex) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                        id: homeProvider
                            .getCategoryChildren![selectedCategoryIndex]
                            .brands![brandIndex]
                            .id!,
                        title: homeProvider
                            .getCategoryChildren![selectedCategoryIndex]
                            .brands![brandIndex]
                            .name!),
                  ),
                );
              },
              child: BrandGridViewItem(
                brand: homeProvider.getCategoryChildren![selectedCategoryIndex]
                    .brands![brandIndex],
              ),
            );
          },
        ),
      ],
    );
  }
}
