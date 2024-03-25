import 'dart:convert';
import 'dart:developer';
import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/product.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/product_details_screen.dart';
import 'package:labees/features/seller/model/seller_profile_response.dart';
import 'package:labees/features/seller/view_model/seller_registration_provider.dart';
import 'package:labees/features/seller/widgets/seller_profile_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 14 - Mar-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description: SellerProfileScreen
*/

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({
    required this.sellerId,
    Key? key}) : super(key: key);

  final int sellerId;

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  final searchController = TextEditingController();

  List<String> searchHistory = [];
  List<Product> searchedProducts = [];

  final Algolia algolia = const Algolia.init(
    applicationId: 'HDY9QG6987',
    apiKey: '36c94cd70996123b660e5ed3abdc0825',
  );

  Future<void> searchAlgolia(String query) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    List<Products> productsList = [];

    AlgoliaQuerySnapshot snapshot =
        await algolia.instance.index('products').query(query).getObjects();

    // Process the search results
    List<AlgoliaObjectSnapshot> hits = snapshot.hits;
    for (AlgoliaObjectSnapshot snap in hits) {
      log('algolia result: ${jsonEncode(snap.data)}');
      productsList.add(Products.fromJson(snap.data));
    }

    homeProvider.addSearchedProducts(productsList);

    print('searched products: ${homeProvider.getSearchedProducts.length}');
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      final sellerRegistrationProvider = Provider.of<SellerRegistrationProvider>(context, listen: false);
      await sellerRegistrationProvider.getSellerProfile(context, widget.sellerId);

      await sellerRegistrationProvider.getSellerProducts(context, widget.sellerId, 10, 1, '');

    });

  }

  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);
    final sellerRegistrationProvider = Provider.of<SellerRegistrationProvider>(context);
    final l10n = AppLocalizations.of(context)!;



    final sellerResponse = sellerRegistrationProvider.sellerProfileResponse ?? SellerProfileResponse(avgRating: 0, totalReview: 0, totalOrder: 0);
    final seller = sellerRegistrationProvider.sellerProfileResponse?.seller ?? Seller();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(l10n.sellerProfileTitle),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await sellerRegistrationProvider.getSellerProfile(context, widget.sellerId);
          await sellerRegistrationProvider.getSellerProducts(context, widget.sellerId, 10, 1, '');
        },
        child: sellerRegistrationProvider.getIsLoading ? const SellerProfileShimmer() :
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  //rounded corner image with border
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: AppColors.lightGrey.withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${APIs.imageBaseURL}${APIs.shop}${seller.shop?.image}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${seller.shop?.name}',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      //rating bar
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating:
                            double.parse(sellerResponse.avgRating.toString()),
                            minRating: 1,
                            itemSize: 20,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ignoreGestures: true,
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.starColor,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: 6),
                          //Text('${product.averageReview} ${l10n.ratingLabel}'),
                          Text('${sellerResponse.avgRating} ${l10n.ratingLabel}'),
                        ],
                      ),

                      Row(
                        children: [

                          //reviews
                          Text(
                            '${sellerResponse.totalReview} ${l10n.reviewsLabel}',
                            style: const TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: 14,
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 1,
                            height: 16,
                            color: AppColors.lightGrey,
                          ),

                          //orders
                          Text(
                            '${sellerResponse.totalOrder} ${l10n.ordersLabel}',
                            style: const TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: 14,
                            ),
                          ),


                        ],
                      ),

                    ],
                  ),

                ],
              ),

              //search bar
              const SizedBox(height: 32),

              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: searchController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: l10n.searchHint,
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        sellerRegistrationProvider.getSellerProducts(context, widget.sellerId, 10, 1, searchController.text.trim());
                      },
                      icon: SvgPicture.asset(
                        Images.searchIcon,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: AppColors.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    sellerRegistrationProvider.getSellerProducts(context, widget.sellerId, 10, 1, value);
                  },
                ),
              ),

              const SizedBox(height: 16),

              //all products label
              Text(
                l10n.allProductsLabel,
                style: const TextStyle(
                  fontFamily: 'Libre Baskerville',
                  fontSize: 18,
                  color: AppColors.primaryColor,
                ),
              ),


              Expanded(
                child: sellerRegistrationProvider.sellerProducts!.isEmpty ? Center(child: Text(l10n.noProducts)) :
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: sellerRegistrationProvider.sellerProducts!.length,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.4,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final product = sellerRegistrationProvider.sellerProducts![index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(
                                    slug: product.slug!),
                          ),
                        );
                      },
                      child: ProductItem(
                        product: product,
                        isSearchProduct: false,
                        addRemoveToWishlist: () async {


                          bool result = await SharedPref.isProductInWishlist(product.id.toString());

                          if (result) {

                            print('remove from wishlist');
                            await SharedPref.removeWishlistProduct(product.id.toString());

                          }
                          else {

                            print('add to wishlist');
                            await SharedPref.addWishlistProduct(product);

                          }


                          //searchAlgolia(searchController.text.trim());
                        },
                      ),
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    searchController.dispose();
  }

}
