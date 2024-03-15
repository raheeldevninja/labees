import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/enums/main_categories.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/category.dart';
import 'package:labees/core/models/product_color.dart';
import 'package:labees/core/models/product_size.dart';
import 'package:labees/core/models/sub_category.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/pages/categories_page/widgets/category_children_section_backup.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/home/widgets/app_drawer.dart';
import 'package:labees/features/my_bag/my_bag_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/notifications/notifications_screen.dart';
import 'package:labees/features/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Categories Page
*/

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  List<Category> categories = [];
  List<SubCategory> subCategories = [];
  List<Brand> brands = [];
  List<ProductSizes> sizes = [];

  List<ProductColor> colorsList = [];

  int mainCategoryIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      homeProvider.setMainCategory(homeProvider.categories![0].name!);

      homeProvider.setChildList(
          homeProvider.getCategoryChildren![0].childes!,
          homeProvider.getCategoryChildren![0].parentId!,
          homeProvider.getCategoryChildren![0].name!);

      homeProvider.getCategoryChildren![0] =
          homeProvider.getCategoryChildren![0].copyWith(isSelected: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final l10n = AppLocalizations.of(context)!;

    if (homeProvider.categories == null) {
      return const Center(
        child: Text('No Categories'),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: SvgPicture.asset(
              Images.menu,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
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
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(12.0),
                    hintText: l10n.searchHint,
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
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
                  color: Colors.white,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 14,
              color: AppColors.primaryColor,
              margin: const EdgeInsets.symmetric(vertical: 16),
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
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///header tabs
          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              width: double.maxFinite,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      onTap: () {
                        setState(() {
                          Utils.mainCategories = MainCategories.men;
                          mainCategoryIndex = 0;
                        });

                        homeProvider.setMainCategoryId(homeProvider
                            .getMainCategoriesList.categories![0].id!);

                        homeProvider.setCategoryChildren(
                            homeProvider.categories![0].childes!);
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Utils.mainCategories == MainCategories.men
                              ? Colors.white
                              : AppColors.primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          homeProvider.categories![0].name!,
                          style: TextStyle(
                            fontSize: 16,
                              color: Utils.mainCategories == MainCategories.men
                                  ? AppColors.primaryColor
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      onTap: () {
                        setState(() {
                          Utils.mainCategories = MainCategories.women;
                          mainCategoryIndex = 1;
                        });

                        homeProvider.setMainCategoryId(homeProvider
                            .getMainCategoriesList.categories![1].id!);

                        homeProvider.setCategoryChildren(
                            homeProvider.categories![1].childes!);
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Utils.mainCategories == MainCategories.women
                              ? Colors.white
                              : AppColors.primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          homeProvider.categories![1].name!,
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Utils.mainCategories == MainCategories.women
                                      ? AppColors.primaryColor
                                      : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      onTap: () {
                        setState(() {
                          Utils.mainCategories = MainCategories.kids;
                          mainCategoryIndex = 2;
                        });

                        homeProvider.setMainCategoryId(homeProvider
                            .getMainCategoriesList.categories![2].id!);

                        homeProvider.setCategoryChildren(
                          homeProvider.categories![2].childes!,
                        );
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Utils.mainCategories == MainCategories.kids
                              ? Colors.white
                              : AppColors.primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          homeProvider.categories![2].name!,
                          style: TextStyle(
                              fontSize: 16,
                              color: Utils.mainCategories == MainCategories.kids
                                  ? AppColors.primaryColor
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await homeProvider.getMainCategories(
                      context, AppLocalizations.of(context)!.localeName);

                  homeProvider.setMainCategory(
                      homeProvider.categories![mainCategoryIndex].name!);

                  homeProvider.setCategoryChildren(
                    homeProvider.categories![mainCategoryIndex].childes!,
                  );
                },
                child: Column(
                  //shrinkWrap: true,
                  //padding: const EdgeInsets.all(16.0),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.allCategories,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Libre Baskerville',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Expanded(child: CategoryChildrenSectionBackup()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }
}
