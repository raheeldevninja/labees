import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/product_color.dart';
import 'package:labees/core/models/product_size.dart';
import 'package:labees/core/ui/product_item.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/attribute_detail.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/models/product_model.dart';
import 'package:labees/features/home/models/tag.dart';
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
    required this.title,
  }) : super(key: key);

  final int id;
  final String title;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  final _minAmountController = TextEditingController();
  final _maxAmountController = TextEditingController();

  //List<Product> products = [];
  List<Category> categories = [];
  List<Brand> brands = [];
  List<ProductSizes> sizes = [];

  bool _isPriorityDeliverySelected = false;
  SfRangeValues _values = SfRangeValues(0.0, 10000.0);

  List<ProductColor> colorsList = [];

  String sortValue = 'Newest';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      await homeProvider.getProducts(context,
          AppLocalizations.of(context)!.localeName, widget.id, 10, 1, 'newest');
      //await homeProvider.getProducts(context, 1, 10, 1, 'newest');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 18, color: AppColors.primaryColor)),

                //drop down
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: sortValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: AppColors.primaryColor),
                    onChanged: (String? newValue) {
                      setState(() {
                        sortValue = newValue!;
                      });

                      String sValue =
                          sortValue.toLowerCase().replaceAll(' ', '_');
                      print('sort value: $sValue');

                      homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          widget.id,
                          10,
                          1,
                          sValue);
                    },
                    items: <String>['Newest', 'Lowest Price', 'Highest Price']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //selected filters chips
          if (homeProvider.selectedSubCategories.isNotEmpty ||
              homeProvider.selectedBrands.isNotEmpty ||
              homeProvider.selectedTags.isNotEmpty ||
              homeProvider.selectedSizeAttributes.isNotEmpty ||
              homeProvider.selectedMinPrice.isNotEmpty ||
              homeProvider.selectedMaxPrice.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (int i = 0;
                      i < homeProvider.selectedSubCategories.length;
                      i++)
                    Chip(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      label: Text(homeProvider.selectedSubCategories[i].name!),
                      onDeleted: () async {
                        homeProvider.subCategories!
                            .firstWhere((element) =>
                                element.id ==
                                homeProvider.selectedSubCategories[i].id)
                            .isSelected = false;
                        homeProvider.selectedSubCategories.removeAt(i);

                        String sValue =
                            sortValue.toLowerCase().replaceAll(' ', '_');

                        await homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          widget.id,
                          10,
                          1,
                          sValue,
                          minAmount: _minAmountController.text.trim(),
                          maxAmount: _maxAmountController.text.trim(),
                          subCategoriesList: homeProvider.subCategories,
                          brands: homeProvider.brandsList,
                          sizeAttributes: homeProvider.selectedSizeAttributes,
                          colorAttributes: homeProvider.selectedColorAttributes,
                          ukSizeAttributes:
                              homeProvider.selectedUkSizeAttributes,
                          tags: homeProvider.selectedTags,
                        );
                      },
                    ),
                  for (int i = 0; i < homeProvider.selectedBrands.length; i++)
                    Chip(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      label: Text(homeProvider.selectedBrands[i].name!),
                      onDeleted: () async {
                        homeProvider.brandsList!
                            .firstWhere((element) =>
                                element.id == homeProvider.selectedBrands[i].id)
                            .isSelected = false;
                        homeProvider.selectedBrands.removeAt(i);

                        String sValue =
                            sortValue.toLowerCase().replaceAll(' ', '_');

                        await homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          widget.id,
                          10,
                          1,
                          sValue,
                          minAmount: _minAmountController.text.trim(),
                          maxAmount: _maxAmountController.text.trim(),
                          subCategoriesList: homeProvider.subCategories,
                          brands: homeProvider.brandsList,
                          sizeAttributes: homeProvider.selectedSizeAttributes,
                          colorAttributes: homeProvider.selectedColorAttributes,
                          ukSizeAttributes:
                              homeProvider.selectedUkSizeAttributes,
                          tags: homeProvider.selectedTags,
                        );
                      },
                    ),
                  for (int i = 0; i < homeProvider.selectedTags.length; i++)
                    Chip(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      label: Text(homeProvider.selectedTags[i].name!),
                      onDeleted: () async {
                        homeProvider.tags!
                            .firstWhere((element) =>
                                element.id == homeProvider.selectedTags[i].id)
                            .isSelected = false;
                        homeProvider.selectedTags.removeAt(i);

                        String sValue =
                            sortValue.toLowerCase().replaceAll(' ', '_');

                        await homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          widget.id,
                          10,
                          1,
                          sValue,
                          minAmount: _minAmountController.text.trim(),
                          maxAmount: _maxAmountController.text.trim(),
                          subCategoriesList: homeProvider.subCategories,
                          brands: homeProvider.brandsList,
                          sizeAttributes: homeProvider.selectedSizeAttributes,
                          colorAttributes: homeProvider.selectedColorAttributes,
                          ukSizeAttributes:
                              homeProvider.selectedUkSizeAttributes,
                          tags: homeProvider.selectedTags,
                        );
                      },
                    ),
                  for (int i = 0;
                      i < homeProvider.selectedSizeAttributes.length;
                      i++)
                    Chip(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      label: Text(homeProvider.selectedSizeAttributes[i].name!),
                      onDeleted: () async {
                        homeProvider.attributes!.forEach((element) {
                          if (element.name == 'Size') {
                            element.attributeValues!.forEach((element) {
                              if (element.id ==
                                  homeProvider.selectedSizeAttributes[i].id) {
                                element.isSelected = false;
                              }
                            });
                          }
                          if (element.name == 'UK Size') {
                            element.attributeValues!.forEach((element) {
                              if (element.id ==
                                  homeProvider.selectedSizeAttributes[i].id) {
                                element.isSelected = false;
                              }
                            });
                          }
                          if (element.name == 'Color') {
                            element.attributeValues!.forEach((element) {
                              if (element.id ==
                                  homeProvider.selectedSizeAttributes[i].id) {
                                element.isSelected = false;
                              }
                            });
                          }
                        });

                        homeProvider.selectedSizeAttributes.removeAt(i);

                        String sValue =
                            sortValue.toLowerCase().replaceAll(' ', '_');

                        await homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          widget.id,
                          10,
                          1,
                          sValue,
                          minAmount: _minAmountController.text.trim(),
                          maxAmount: _maxAmountController.text.trim(),
                          subCategoriesList: homeProvider.subCategories,
                          brands: homeProvider.brandsList,
                          sizeAttributes: homeProvider.selectedSizeAttributes,
                          colorAttributes: homeProvider.selectedColorAttributes,
                          ukSizeAttributes:
                              homeProvider.selectedUkSizeAttributes,
                          tags: homeProvider.selectedTags,
                        );
                      },
                    ),
                  if (homeProvider.selectedMinPrice.isNotEmpty)
                    Chip(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      label: Text(homeProvider.selectedMinPrice),
                      onDeleted: () async {
                        homeProvider.setSelectedMinPrice('');

                        String sValue =
                            sortValue.toLowerCase().replaceAll(' ', '_');

                        await homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          widget.id,
                          10,
                          1,
                          sValue,
                          minAmount: _minAmountController.text.trim(),
                          maxAmount: _maxAmountController.text.trim(),
                          subCategoriesList: homeProvider.subCategories,
                          brands: homeProvider.brandsList,
                          sizeAttributes: homeProvider.selectedSizeAttributes,
                          colorAttributes: homeProvider.selectedColorAttributes,
                          ukSizeAttributes:
                              homeProvider.selectedUkSizeAttributes,
                          tags: homeProvider.selectedTags,
                        );
                      },
                    ),
                  if (homeProvider.selectedMaxPrice.isNotEmpty)
                    Chip(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      label: Text(homeProvider.selectedMaxPrice),
                      onDeleted: () async {
                        homeProvider.setSelectedMaxPrice('');

                        String sValue =
                            sortValue.toLowerCase().replaceAll(' ', '_');

                        await homeProvider.getProducts(
                          context,
                          AppLocalizations.of(context)!.localeName,
                          widget.id,
                          10,
                          1,
                          sValue,
                          minAmount: _minAmountController.text.trim(),
                          maxAmount: _maxAmountController.text.trim(),
                          subCategoriesList: homeProvider.subCategories,
                          brands: homeProvider.brandsList,
                          sizeAttributes: homeProvider.selectedSizeAttributes,
                          colorAttributes: homeProvider.selectedColorAttributes,
                          ukSizeAttributes:
                              homeProvider.selectedUkSizeAttributes,
                          tags: homeProvider.selectedTags,
                        );
                      },
                    ),
                ],
              ),
            ),
          ],

          const SizedBox(
            height: 10,
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
                                    product.wishlist!.productId == product.id) {
                                  ///remove from wishlist
                                  await homeProvider
                                      .removeFromWishlist(product.id!);
                                } else {
                                  print('here');

                                  ///add to wishlist
                                  await homeProvider.addToWishList(
                                      context,
                                      AppLocalizations.of(context)!.localeName,
                                      product.id!);
                                }

                                String sValue = sortValue
                                    .toLowerCase()
                                    .replaceAll(' ', '_');
                                print('sort value: $sValue');

                                await homeProvider.getProducts(
                                    context,
                                    AppLocalizations.of(context)!.localeName,
                                    widget.id,
                                    10,
                                    1,
                                    sValue,
                                    showShimmer: false);
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
            child: FilterBottomSheet(
              id: widget.id,
              sortValue: sortValue,
            ),
          );
        });
      },
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet(
      {required this.id, required this.sortValue, super.key});

  final int id;
  final String sortValue;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  var _minAmountController = TextEditingController();
  var _maxAmountController = TextEditingController();

  List<SubCategories> subCategories = [];
  List<Brand> brands = [];

  List<AttributeValues> sizeAttributes = [];
  List<AttributeValues> colorAttributes = [];
  List<Tag> tags = [];
  List<AttributeValues> ukSizeAttributes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      for (int i = 0; i < homeProvider.selectedSubCategories.length; i++) {
        homeProvider.getSubCategories!.forEach((element) {
          if (element.id == homeProvider.selectedSubCategories[i].id) {
            element.isSelected = true;
          }
        });
      }

      for (int i = 0; i < homeProvider.selectedBrands.length; i++) {
        homeProvider.getBrands!.forEach((element) {
          if (element.id == homeProvider.selectedBrands[i].id) {
            element.isSelected = true;
          }
        });
      }

      for (int i = 0; i < homeProvider.selectedTags.length; i++) {
        homeProvider.getTags!.forEach((element) {
          if (element.id == homeProvider.selectedTags[i].id) {
            element.isSelected = true;
          }
        });
      }

      for (int i = 0; i < homeProvider.selectedSizeAttributes.length; i++) {
        homeProvider.attributes!.forEach((element) {
          if (element.name == 'Size') {
            element.attributeValues!.forEach((element) {
              if (element.id == homeProvider.selectedSizeAttributes[i].id) {
                element.isSelected = true;
              }
            });
          }
          if (element.name == 'UK Size') {
            element.attributeValues!.forEach((element) {
              if (element.id == homeProvider.selectedSizeAttributes[i].id) {
                element.isSelected = true;
              }
            });
          }
          if (element.name == 'Color') {
            element.attributeValues!.forEach((element) {
              if (element.id == homeProvider.selectedSizeAttributes[i].id) {
                element.isSelected = true;
              }
            });
          }
        });

        _minAmountController.text = homeProvider.selectedMinPrice;
        _maxAmountController.text = homeProvider.selectedMaxPrice;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final homeProvider = Provider.of<HomeProvider>(context);

    print('tags: ${homeProvider.getTags!.isEmpty}');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Images.filterIcon,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '${l10n.filters}: ',
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close, color: AppColors.primaryColor),
              ),
            ],
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
                for (int i = 0; i < homeProvider.getSubCategories!.length; i++)
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      /*setState(() {
                                homeProvider.getSubCategories![i].isSelected =
                                    !homeProvider
                                        .getSubCategories![i].isSelected;
                              });*/

                      //toggle sub category
                      homeProvider.toggleSubCategories(i);

                      homeProvider.addRemoveSelectedSubCategories(
                          homeProvider.getSubCategories![i]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: homeProvider.getSubCategories![i].isSelected
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
                for (int i = 0; i < homeProvider.getBrands!.length; i++) ...[
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      /*setState(() {
                                homeProvider.getBrands![i].isSelected =
                                    !homeProvider.getBrands![i].isSelected;
                              });*/

                      homeProvider.toggleBrands(i);
                      homeProvider
                          .addRemoveSelectedBrands(homeProvider.getBrands![i]);
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

          //tags

          if (homeProvider.getTags!.isNotEmpty) ...[
            Text(
              l10n.tags,
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
                for (int i = 0; i < homeProvider.getTags!.length; i++)
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      /*setState(() {
                                homeProvider.getTags![i].isSelected =
                                    !homeProvider.getTags![i].isSelected;
                              });*/

                      homeProvider.toggleTags(i);

                      homeProvider
                          .addRemoveSelectedTags(homeProvider.getTags![i]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: homeProvider.getTags![i].isSelected
                            ? AppColors.selectedOption.withOpacity(0.3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        homeProvider.getTags![i].name!,
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

          const SizedBox(
            height: 20,
          ),

          //min amount text field
          const Text(
            'Min Amount',
            style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400),
          ),

          const SizedBox(
            height: 10,
          ),

          TextFormField(
            controller: _minAmountController,
            onChanged: (value) {
              homeProvider.setSelectedMinPrice(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sar '),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              prefixStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: AppColors.blackColor),
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12.0),
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //max amount text field
          const Text(
            'Max Amount',
            style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400),
          ),

          const SizedBox(
            height: 10,
          ),

          TextFormField(
            controller: _maxAmountController,
            onChanged: (value) {
              homeProvider.setSelectedMaxPrice(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Sar '),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 0, minHeight: 0),
              prefixStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: AppColors.blackColor),
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12.0),
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
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
                    j < homeProvider.attributes![i].attributeValues!.length;
                    j++)
                  InkWell(
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () {
                      /*setState(() {
                                homeProvider.attributes![i].attributeValues![j]
                                        .isSelected =
                                    !homeProvider.attributes![i]
                                        .attributeValues![j].isSelected;
                              });*/

                      homeProvider.toggleAttribute(i, j);

                      homeProvider.addRemoveSelectedSizeAttributes(
                          homeProvider.attributes![i].attributeValues![j]);
                    },
                    child: Container(
                      padding: homeProvider.attributes![i].name != 'Color'
                          ? const EdgeInsets.all(8.0)
                          : const EdgeInsets.all(1.0),
                      decoration: homeProvider.attributes![i].name != 'Color'
                          ? BoxDecoration(
                              color: homeProvider.attributes![i]
                                      .attributeValues![j].isSelected
                                  ? AppColors.selectedOption.withOpacity(0.3)
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
                              homeProvider
                                  .attributes![i].attributeValues![j].name!,
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

                final homeProvider =
                    Provider.of<HomeProvider>(context, listen: false);

                // List<AttributeValues> sizeAttributes = [];
                // List<AttributeValues> colorAttributes = [];
                // List<Tag> tags = [];
                // List<AttributeValues> ukSizeAttributes = [];

                sizeAttributes = [];
                colorAttributes = [];
                tags = [];
                ukSizeAttributes = [];

                //get selected size attributes
                for (int i = 0; i < homeProvider.attributes!.length; i++) {
                  if (homeProvider.attributes![i].name == 'Size') {
                    for (int j = 0;
                        j < homeProvider.attributes![i].attributeValues!.length;
                        j++) {
                      if (homeProvider
                          .attributes![i].attributeValues![j].isSelected) {
                        sizeAttributes.add(
                            homeProvider.attributes![i].attributeValues![j]);
                      }
                    }
                  }
                }

                //get selected color attributes
                for (int i = 0; i < homeProvider.attributes!.length; i++) {
                  if (homeProvider.attributes![i].name == 'Color') {
                    for (int j = 0;
                        j < homeProvider.attributes![i].attributeValues!.length;
                        j++) {
                      if (homeProvider
                          .attributes![i].attributeValues![j].isSelected) {
                        colorAttributes.add(
                            homeProvider.attributes![i].attributeValues![j]);
                      }
                    }
                  }
                }

                //get selected uk size attributes
                for (int i = 0; i < homeProvider.attributes!.length; i++) {
                  if (homeProvider.attributes![i].name == 'UK Size') {
                    for (int j = 0;
                        j < homeProvider.attributes![i].attributeValues!.length;
                        j++) {
                      if (homeProvider
                          .attributes![i].attributeValues![j].isSelected) {
                        ukSizeAttributes.add(
                            homeProvider.attributes![i].attributeValues![j]);
                      }
                    }
                  }
                }

                //tags
                for (int i = 0; i < homeProvider.getTags!.length; i++) {
                  if (homeProvider.getTags![i].isSelected) {
                    tags.add(homeProvider.getTags![i]);
                  }
                }

                String sValue =
                    widget.sortValue.toLowerCase().replaceAll(' ', '_');

                await homeProvider.getProducts(
                  context,
                  AppLocalizations.of(context)!.localeName,
                  widget.id,
                  10,
                  1,
                  sValue,
                  //minAmount: _values.start.round().toString(),
                  minAmount: _minAmountController.text.trim(),
                  //maxAmount: _values.end.round().toString(),
                  maxAmount: _maxAmountController.text.trim(),
                  subCategoriesList: homeProvider.subCategories,
                  brands: homeProvider.brandsList,
                  sizeAttributes: sizeAttributes,
                  colorAttributes: colorAttributes,
                  ukSizeAttributes: ukSizeAttributes,
                  tags: tags,
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

                _minAmountController.clear();
                _maxAmountController.clear();

                final homeProvider =
                    Provider.of<HomeProvider>(context, listen: false);

                homeProvider.clearFilters();

                String sValue =
                    widget.sortValue.toLowerCase().replaceAll(' ', '_');

                await homeProvider.getProducts(
                    context,
                    AppLocalizations.of(context)!.localeName,
                    widget.id,
                    10,
                    1,
                    sValue);
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
                    style: const TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
