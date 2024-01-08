import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/brand.dart';
import 'package:labees/core/models/category.dart';
import 'package:labees/core/models/product_color.dart';
import 'package:labees/core/models/product_size.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/attribute_detail.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/home/widgets/app_drawer.dart';
import 'package:labees/features/my_bag/my_bag_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/notifications/notifications_screen.dart';
import 'package:labees/features/products/product_details_screen.dart';
import 'package:labees/features/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:shimmer/shimmer.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 27 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ProductsScreen
*/

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  //List<Product> products = [];
  List<Category> categories = [];
  List<Brand> brands = [];
  List<ProductSizes> sizes = [];

  bool _isPriorityDeliverySelected = false;
  SfRangeValues _values = SfRangeValues(0.0, 10000.0);

  List<ProductColor> colorsList = [];

  @override
  void initState() {
    super.initState();

    /*_initWishList();
    _initCategories();
    _initBrands();
    _initColorsList();
    _initSizes();*/

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.getProducts(context,
          AppLocalizations.of(context).localeName, widget.id, 10, 1, 'newest');
      //await homeProvider.getProducts(context, 1, 10, 1, 'newest');
    });
  }

  /*_initWishList() {
    products.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    products.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    products.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    products.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );

    products.add(
      Product(
          productBrand: 'Versace',
          productName: 'T-shirt',
          price: 5500,
          productImage:
              'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png'),
    );
  }

  _initCategories() {
    categories.add(Category(name: 'Dresses', isSelected: true));
    categories.add(Category(name: 'Coats & Jackets'));
    categories.add(Category(name: 'Tops'));
    categories.add(Category(name: 'Trousers', isSelected: true));
    categories.add(Category(name: 'Jeans'));
    categories.add(Category(name: 'Skirts'));
    categories.add(Category(name: 'Shoes', isSelected: true));
    categories.add(Category(name: 'Bags'));
  }

  _initBrands() {
    brands.add(Brand(name: 'Versace', isSelected: true));
    brands.add(Brand(name: 'Gucci'));
    brands.add(Brand(name: 'Chanel'));
    brands.add(Brand(name: 'Dior'));
  }

  _initSizes() {
    sizes.add(ProductSizes(size: 'S', isSelected: true));
    sizes.add(ProductSizes(size: 'M'));
    sizes.add(ProductSizes(size: 'L'));
    sizes.add(ProductSizes(size: 'XL'));
    sizes.add(ProductSizes(size: 'XXL'));
  }

  _initColorsList() {
    colorsList.add(ProductColor(color: Colors.red));
    colorsList.add(ProductColor(color: Colors.blue));
    colorsList.add(ProductColor(color: Colors.green));
    colorsList.add(ProductColor(color: Colors.yellow));
    colorsList.add(ProductColor(color: Colors.purple));
    colorsList.add(ProductColor(color: Colors.orange));
    colorsList.add(ProductColor(color: Colors.pink));
    colorsList.add(ProductColor(color: Colors.brown));
    colorsList.add(ProductColor(color: Colors.grey));
    colorsList.add(ProductColor(color: Colors.black));
    colorsList.add(ProductColor(color: Colors.white));
  }*/

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final homeProvider = Provider.of<HomeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            if (!homeProvider.getIsLoading) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
        ),
        title: SizedBox(
          height: 40,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: _searchController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: l10n.searchHint,
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
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _openFilterBottomSheet(l10n);
            },
            icon: SvgPicture.asset(
              Images.filterIcon,
              color: AppColors.primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyBagScreen(),
                ),
              );
            },
            icon: badges.Badge(
              badgeContent: Text(
                cartProvider.cartProducts.length.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: SvgPicture.asset(
                Images.cartIcon,
                width: 24,
                height: 24,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
            icon: SvgPicture.asset(
              Images.notificationsIcon,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Text(l10n.newInHeading,
                style: const TextStyle(
                    fontSize: 18, color: AppColors.primaryColor)),
          ),
          Expanded(
            child: homeProvider.getIsLoading
                ? GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                : homeProvider.products!.isEmpty
                    ? Center(child: Text(l10n.noProducts))
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: homeProvider.products!.length,
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.55,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          //final product = products[index];
                          final product = homeProvider.products![index];

                          print('wishlist in all products ${product.wishlist}');

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      slug: product.slug ?? ''),
                                ),
                              );
                            },
                            child: ProductItem(
                              product: product,
                              addRemoveToWishlist: () async {

                                if (product.wishlist != null &&
                                    product.wishlist!.productId ==
                                        product.id) {
                                  ///remove from wishlist
                                  await homeProvider
                                      .removeFromWishlist(product.id!);
                                } else {
                                  print('here');

                                  ///add to wishlist
                                  await homeProvider.addToWishList(
                                      context, AppLocalizations.of(context).localeName, product.id!);
                                }

                                await homeProvider.getProducts(context,
                                    AppLocalizations.of(context).localeName, widget.id, 10, 1, 'newest', showShimmer: false);


                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  _openFilterBottomSheet(AppLocalizations l10n) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      builder: (BuildContext context) {
        final homeProvider = Provider.of<HomeProvider>(context);

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return FractionallySizedBox(
            heightFactor: 0.75,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${l10n.filterBy}: ',
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //rounded corner border container
                  /*InkWell(
                    onTap: () {
                      setState(() {
                        _isPriorityDeliverySelected =
                            !_isPriorityDeliverySelected;
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _isPriorityDeliverySelected
                            ? AppColors.selectedOption
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Priority Delivery',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: AppColors.blackColor),
                      ),
                    ),
                  ),*/
                  const SizedBox(
                    height: 30,
                  ),

                  if (homeProvider.getSubCategories!.isNotEmpty) ...[
                    Text(
                      l10n.categoryLabel,
                      style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (int i = 0;
                            i < homeProvider.getSubCategories!.length;
                            i++)
                          InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () {
                              setState(() {
                                homeProvider.getSubCategories![i].isSelected =
                                    !homeProvider
                                        .getSubCategories![i].isSelected;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: homeProvider
                                        .getSubCategories![i].isSelected
                                    ? AppColors.selectedOption.withOpacity(0.3)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                homeProvider.getSubCategories![i].name!,
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: AppColors.blackColor),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],

                  if (homeProvider.getBrands!.isNotEmpty) ...[
                    Text(
                      l10n.filterBrands,
                      style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /*Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (int i = 0; i < brands.length; i++)
                        InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            setState(() {
                              brands[i] = brands[i]
                                  .copyWith(isSelected: !brands[i].isSelected);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: brands[i].isSelected
                                  ? AppColors.selectedOption.withOpacity(0.3)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppColors.borderColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              brands[i].name,
                              style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: AppColors.blackColor),
                            ),
                          ),
                        ),
                    ],
                  ),*/

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (int i = 0;
                            i < homeProvider.getBrands!.length;
                            i++) ...[
                          InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () {
                              setState(() {
                                homeProvider.getBrands![i].isSelected =
                                    !homeProvider.getBrands![i].isSelected;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: homeProvider.getBrands![i].isSelected
                                    ? AppColors.selectedOption.withOpacity(0.3)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                homeProvider.getBrands![i].name!,
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: AppColors.blackColor),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.priceLabel,
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: AppColors.borderColor.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Sar ${_values.end.round()}',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              color: AppColors.blackColor),
                        ),
                      ),
                    ],
                  ),

                  SfRangeSlider(
                    min: 0.0,
                    max: 10000.0,
                    values: _values,
                    interval: 100,
                    stepSize: 100,
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: false,
                    showDividers: false,
                    minorTicksPerInterval: 100,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _values = values;
                      });
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //start range and end range
                        Expanded(
                          child: Text(
                            'Sar ${_values.start.round()}',
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: AppColors.blackColor),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Sar ${_values.end.round()}',
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                color: AppColors.blackColor),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  for (int i = 0; i < homeProvider.attributes!.length; i++) ...[
                    Text(
                      homeProvider.attributes![i].name!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (int j = 0;
                            j <
                                homeProvider
                                    .attributes![i].attributeValues!.length;
                            j++)
                          InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              setState(() {
                                homeProvider.attributes![i].attributeValues![j]
                                        .isSelected =
                                    !homeProvider.attributes![i]
                                        .attributeValues![j].isSelected;
                              });
                            },
                            child: Container(
                              padding:
                                  homeProvider.attributes![i].name != 'Color'
                                      ? const EdgeInsets.all(8.0)
                                      : const EdgeInsets.all(1.0),
                              decoration: homeProvider.attributes![i].name !=
                                      'Color'
                                  ? BoxDecoration(
                                      color: homeProvider.attributes![i]
                                              .attributeValues![j].isSelected
                                          ? AppColors.selectedOption
                                              .withOpacity(0.3)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 1,
                                      ),
                                    )
                                  : BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: homeProvider.attributes![i]
                                                .attributeValues![j].isSelected
                                            ? AppColors.blackColor
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                              child: homeProvider.attributes![i].name == 'Color'
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60.0),
                                      child: SvgPicture.network(
                                        '${APIs.imageBaseURL}${APIs.attributeValue}${homeProvider.attributes![i].attributeValues![j].image!}',
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  : Text(
                                      homeProvider.attributes![i]
                                          .attributeValues![j].name!,
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          color: AppColors.blackColor),
                                    ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);

                        print('min amount: ${_values.start.round()}');
                        print('max amount: ${_values.end.round()}');

                        final homeProvider =
                            Provider.of<HomeProvider>(context, listen: false);

                        List<AttributeValues> sizeAttributes = [];
                        List<AttributeValues> colorAttributes = [];
                        List<AttributeValues> ukSizeAttributes = [];

                        //get selected size attributes
                        for (int i = 0;
                            i < homeProvider.attributes!.length;
                            i++) {
                          if (homeProvider.attributes![i].name == 'Size') {
                            for (int j = 0;
                                j <
                                    homeProvider
                                        .attributes![i].attributeValues!.length;
                                j++) {
                              if (homeProvider.attributes![i]
                                  .attributeValues![j].isSelected) {
                                sizeAttributes.add(homeProvider
                                    .attributes![i].attributeValues![j]);
                              }
                            }
                          }
                        }

                        //get selected color attributes
                        for (int i = 0;
                            i < homeProvider.attributes!.length;
                            i++) {
                          if (homeProvider.attributes![i].name == 'Color') {
                            for (int j = 0;
                                j <
                                    homeProvider
                                        .attributes![i].attributeValues!.length;
                                j++) {
                              if (homeProvider.attributes![i]
                                  .attributeValues![j].isSelected) {
                                colorAttributes.add(homeProvider
                                    .attributes![i].attributeValues![j]);
                              }
                            }
                          }
                        }

                        //get selected uk size attributes
                        for (int i = 0;
                            i < homeProvider.attributes!.length;
                            i++) {
                          if (homeProvider.attributes![i].name == 'UK Size') {
                            for (int j = 0;
                                j <
                                    homeProvider
                                        .attributes![i].attributeValues!.length;
                                j++) {
                              if (homeProvider.attributes![i]
                                  .attributeValues![j].isSelected) {
                                ukSizeAttributes.add(homeProvider
                                    .attributes![i].attributeValues![j]);
                              }
                            }
                          }
                        }

                        await homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context).localeName,
                          widget.id,
                          10,
                          1,
                          'newest',
                          minAmount: _values.start.round().toString(),
                          maxAmount: _values.end.round().toString(),
                          subCategoriesList: homeProvider.subCategories,
                          brands: homeProvider.brandsList,
                          sizeAttributes: sizeAttributes,
                          colorAttributes: colorAttributes,
                          ukSizeAttributes: ukSizeAttributes,
                        );

                        /*await homeProvider.getProducts(
                            context, 1, 10, 1, 'newest',
                          filterData: filterData
                        );*/
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                      child: Text(
                        l10n.filterBtnText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);

                        _values = const SfRangeValues(0.0, 10000.0);

                        final homeProvider =
                            Provider.of<HomeProvider>(context, listen: false);

                        homeProvider.clearFilters();

                        await homeProvider.getProducts(
                            context,
                            AppLocalizations.of(context).localeName,
                            widget.id,
                            10,
                            1,
                            'newest');
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 1.0,
                          color: AppColors.primaryColor,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.clearFilterBtnText,
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
