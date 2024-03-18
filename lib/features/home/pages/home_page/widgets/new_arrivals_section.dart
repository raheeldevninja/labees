import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
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
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),

        ///new arrivals listview
        const SizedBox(height: 10),

        SizedBox(
          height: 360,
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

                    bool result = await SharedPref.isProductInWishlist(product.id.toString());

                    if (result) {

                      print('remove from wishlist');
                      await SharedPref.removeWishlistProduct(product.id.toString());

                    }
                    else {

                      print('add to wishlist');
                      await SharedPref.addWishlistProduct(product);

                    }




                    // if (product.wishlist != null &&
                    //     product.wishlist!.productId == product.id) {
                    //
                    //   await homeProvider.removeFromWishlist(product.id!);
                    // } else {
                    //
                    //   await homeProvider.addToWishList(
                    //       context,
                    //       AppLocalizations.of(context)!.localeName,
                    //       product.id!);
                    // }

                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Future<bool?> _showLoginDialog(
      BuildContext context, AppLocalizations l10n) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please login to add product to wishlist'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.yesBtnText),
              onPressed: () {

                Utils.controller.jumpToTab(3);
                Navigator.of(context).pop(true);

              },
            ),
            TextButton(
              child: Text(l10n.noBtnText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

}
