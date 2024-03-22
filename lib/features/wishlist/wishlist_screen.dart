import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 12 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: WishlistScreen
*/

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  List<Products>? wishlistProducts = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // context
      //     .read<HomeProvider>()
      //     .getWishlist(context, AppLocalizations.of(context)!.localeName);

      wishlistProducts = await SharedPref.getWishlistProducts();

      setState(() {});
    });
  }



  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
                '${l10n.wishlistTitle} ${wishlistProducts?.length ?? 0}',
                style: const TextStyle(color: AppColors.primaryColor)),
      ),
      body: /*homeProvider.getIsLoading
          ? GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.55,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          :*/
      GridView.builder(
              itemCount: wishlistProducts?.length ?? 0,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.43,
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 10.0, // Spacing between rows
                crossAxisSpacing: 10.0, // Spacing between columns
              ),
              itemBuilder: (BuildContext context, int index) {

                final wishlistProduct = wishlistProducts?[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                            slug: wishlistProduct!.slug!),
                      ),
                    );
                  },
                  child: ProductItem(
                    isWishlistProduct: true,
                    /*product: homeProvider.getWishlistData?[index].product ??
                        Products(),*/

                    product: wishlistProduct ?? Products(),

                    addRemoveToWishlist: () async {
                      print('add remove called');

                      await SharedPref.removeWishlistProduct(wishlistProduct!.id.toString());

                      wishlistProducts = await SharedPref.getWishlistProducts();

                      setState(() {});

                    },
                  ),
                );
              },
            ),
    );
  }
}
