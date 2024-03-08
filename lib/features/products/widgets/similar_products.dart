import 'package:flutter/material.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 23 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ProductDetailsScreen
*/

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({
    super.key,
    required this.slug,
  });

  final String slug;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return GridView.builder(
      shrinkWrap: true,
      itemCount: homeProvider.productDetails!.product!.similarProducts!.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.56,
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final product =
            homeProvider.productDetails!.product!.similarProducts![index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(slug: product.slug ?? ''),
              ),
            );
          },
          child: ProductItem(
            product: product,
            addRemoveToWishlist: () async {
              if (product.wishlist != null &&
                  product.wishlist!.productId == product.id) {
                ///remove from wishlist
                await homeProvider.removeFromWishlist(product.id!);
              } else {
                print('here');

                ///add to wishlist
                await homeProvider.addToWishList(context,
                    AppLocalizations.of(context)!.localeName, product.id!);
              }

              await homeProvider.getProductDetails(
                  context, AppLocalizations.of(context)!.localeName, slug);
            },
          ),
        );
        //return SizedBox();
      },
    );
  }
}
