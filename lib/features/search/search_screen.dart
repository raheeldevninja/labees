import 'dart:convert';
import 'dart:developer';
import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/product.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 12 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: SearchScreen
*/

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

    _initSearchHistory();
    _initSearchedProducts();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: SizedBox(
          height: 40,
          child: TextFormField(
            controller: searchController,
            maxLines: 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12.0),
              hintText: 'Search...',
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              suffixIcon: IconButton(
                onPressed: () {},
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
              searchAlgolia(value);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*const Text(
              'Recent Searches',
              style: TextStyle(
                fontFamily: 'Libre Baskerville',
                fontSize: 18,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                for (var item in searchHistory)
                  SizedBox(
                    width: 90,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                              color: AppColors.borderColor, width: 1.0),
                        ),
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            */



            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  l10n.poweredByAlgolia,
                  style: const TextStyle(
                    fontFamily: 'Libre Baskerville',
                    fontSize: 12,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Expanded(
              child: homeProvider.getSearchedProducts.isEmpty ? Center(child: Text(l10n.noProducts)) :
              GridView.builder(
                shrinkWrap: true,
                //itemCount: searchedProducts.length,
                itemCount: homeProvider.getSearchedProducts.length,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final product = homeProvider.getSearchedProducts[index];
                  return InkWell(
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsScreen(
                                  slug: product.slug!),
                        ),
                      );*/
                    },
                    child: ProductItem(
                      product: product,
                      isSearchProduct: true,
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

                        print('query: ${searchController.text.trim()}');

                        searchAlgolia(searchController.text.trim());
                      },
                    ),
                  );

                  //final product = searchedProducts[index];
                  //return ProductItem(product: product);
                  //return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initSearchHistory() {
    searchHistory.add('Casual');
    searchHistory.add('Formal');
    searchHistory.add('Sport');
    searchHistory.add('Shoes');
    searchHistory.add('T-Shirt');
    searchHistory.add('Jeans');
  }

  _initSearchedProducts() {
    searchedProducts.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    searchedProducts.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    searchedProducts.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    searchedProducts.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    searchedProducts.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );
  }
}
