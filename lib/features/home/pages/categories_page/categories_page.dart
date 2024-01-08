import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/category.dart';
import 'package:labees/core/models/product_color.dart';
import 'package:labees/core/models/product_size.dart';
import 'package:labees/core/models/sub_category.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/pages/categories_page/widgets/brands_section.dart';
import 'package:labees/features/home/pages/categories_page/widgets/category_children_section.dart';
import 'package:labees/features/home/pages/categories_page/widgets/main_categories_row.dart';
import 'package:labees/features/home/pages/categories_page/widgets/sub_categories_section.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      homeProvider.setMainCategory(
          homeProvider.categories![0].name!);

      homeProvider.setChildList(homeProvider
          .getCategoryChildren![0].childes!);

      homeProvider.getCategoryChildren![0] =
          homeProvider.getCategoryChildren![0]
              .copyWith(isSelected: true);

    });

  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final l10n = AppLocalizations.of(context);

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
          backgroundColor: AppColors.secondaryColor,
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: SvgPicture.asset(
              Images.menu,
              width: 24,
              height: 24,
              color: AppColors.primaryColor,
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
                  color: AppColors.primaryColor,
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
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              height: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  ///left section
                  const CategoryChildrenSection(),

                  const SizedBox(width: 4),

                  ///right section
                  Expanded(
                    child: ListView(
                      children: [

                        ///main categories row
                        const MainCategoriesRow(),

                        ///sub categories section
                        const SubCategoriesSection(),

                        const SizedBox(
                          height: 16,
                        ),

                        ///brands section
                        BrandsSection(
                          //selectedCategoryIndex: _selectedCategoryIndex,
                          selectedCategoryIndex: homeProvider.getSelectedCategoryIndex,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }
}


