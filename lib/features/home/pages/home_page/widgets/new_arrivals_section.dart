import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/product_details_screen.dart';
import 'package:provider/provider.dart';

/*
*  Date 16 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: NewArrivalsSection
*/

class NewArrivalsSection extends StatefulWidget {
  const NewArrivalsSection({
    Key? key,
  }) : super(key: key);

  @override
  State<NewArrivalsSection> createState() => _NewArrivalsSectionState();
}

class _NewArrivalsSectionState extends State<NewArrivalsSection> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.newArrivals,
          style: const TextStyle(
            fontFamily: 'Libre Baskerville',
            fontSize: 18,
            color: AppColors.primaryColor,
          ),
        ),

        const SizedBox(height: 10),

        ///new arrivals listview
        const SizedBox(height: 20),

        SizedBox(
          height: 290,
          child: ListView.builder(
            itemCount: homeProvider.getNewArrivalProducts.products!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final product =
                  homeProvider.getNewArrivalProducts.products![index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(slug: product.slug!),
                    ),
                  );
                },
                child: ProductItem(
                  product: product,
                  addRemoveToWishlist: () async {
                    print('wishlist ${product.wishlist}');

                    if (product.wishlist != null &&
                        product.wishlist!.productId == product.id) {
                      ///remove from wishlist
                      await homeProvider.removeFromWishlist(product.id!);
                    } else {
                      print('here');

                      ///add to wishlist
                      await homeProvider.addToWishList(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          product.id!);
                    }

                    int categoryId = homeProvider
                        .getMainCategoriesList.categories!.first.id!;

                    if (mounted) {
                      await homeProvider.getDashboardData(
                          context,
                          false,
                          AppLocalizations.of(context)!.localeName,
                          categoryId,
                          'all');
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
