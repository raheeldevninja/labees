import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/ui/home_shimmer.dart';
import 'package:labees/features/home/pages/home_page/widgets/category_carousel_item.dart';
import 'package:labees/features/home/pages/home_page/widgets/most_wanted_section.dart';
import 'package:labees/features/home/pages/home_page/widgets/new_arrivals_section.dart';
import 'package:labees/features/home/pages/home_page/widgets/shop_now_banner.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/home/widgets/app_drawer.dart';
import 'package:labees/features/my_bag/my_bag_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/notifications/notifications_screen.dart';
import 'package:labees/features/products/products_screen.dart';
import 'package:labees/features/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 15 - March-2024
*  Author: Raheel Khan- Abaska Technologies
*  Description: Home Page
*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  //MainCategories mainCategories = MainCategories.men;

  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.getMainCategories(
          context, AppLocalizations.of(context)!.localeName);

      if (homeProvider.getMainCategoriesList.categories != null) {
        int categoryId =
            homeProvider.getMainCategoriesList.categories!.first.id!;

        if (mounted) {
          await homeProvider.getDashboardData(context, true,
              AppLocalizations.of(context)!.localeName, categoryId, 'all');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final homeProvider = Provider.of<HomeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    if (homeProvider.getCategoryChildren == null) {
      return const SizedBox();
    }

    final List<Widget> imageSliders = homeProvider.getCategoryChildren!
        .map((item) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductsScreen(id: item.id!, title: item.name!),
                  ),
                );
              },
              child: CategoryCarouselItem(item: item),
            ))
        .toList();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                Images.searchIcon,
                color: Colors.white,
              ),
            ),
          ],
        ),
        title:

            SvgPicture.asset(
          Images.labeesAppbar,
          color: Colors.white,
        ),
        centerTitle: true,
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
                width: 24,
                height: 24,
              ),
            ),
          ),
          //vertical bar separator
          Container(
            width: 1,
            height: 14,
            color: Colors.white,
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
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: homeProvider.getIsLoading
          ? const HomeShimmer()
          : (homeProvider.categories == null)
              ? const SizedBox.shrink()
              : RefreshIndicator(
                  onRefresh: () async {
                    final homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);
                    await homeProvider.getMainCategories(
                        context, AppLocalizations.of(context)!.localeName);

                    if (homeProvider.getMainCategoriesList.categories != null) {
                      int categoryId = homeProvider
                          .getMainCategoriesList.categories!.first.id!;

                      if (mounted) {
                        await homeProvider.getDashboardData(
                            context,
                            true,
                            AppLocalizations.of(context)!.localeName,
                            categoryId,
                            'all');
                      }
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          children: const [
                            ShopNowBanner(),
                            SizedBox(height: 20),
                            MostWantedSection(),
                            SizedBox(height: 20),
                            NewArrivalsSection(),
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
