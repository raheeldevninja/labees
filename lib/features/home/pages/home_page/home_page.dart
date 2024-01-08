import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/enums/main_categories.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/ui/home_shimmer.dart';
import 'package:labees/core/util/utils.dart';
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
*  Date 11 - September-2023
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
          context, AppLocalizations.of(context).localeName);

      if (homeProvider.getMainCategoriesList.categories != null) {
        int categoryId =
            homeProvider.getMainCategoriesList.categories!.first.id!;

        if (mounted) {
          await homeProvider.getDashboardData(context, true,
              AppLocalizations.of(context).localeName, categoryId, 'all');
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
                    builder: (context) => ProductsScreen(id: item.id!),
                  ),
                );
              },
              child: CategoryCarouselItem(item: item),
            ))
        .toList();


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        shadowColor: Colors.transparent,
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
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ///header section
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.maxFinite,
                          color: AppColors.primaryColor,
                          child: Column(
                            children: [
                              //tabs
                              Container(
                                width: double.maxFinite,
                                height: 32,
                                margin: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
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
                                          });

                                          homeProvider.setCategoryChildren(
                                              homeProvider
                                                  .categories![0].childes!);
                                        },
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Utils.mainCategories ==
                                                    MainCategories.men
                                                ? Colors.white
                                                : AppColors.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            homeProvider.categories![0].name!,
                                            style: TextStyle(
                                                color: Utils.mainCategories ==
                                                        MainCategories.men
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
                                            Utils.mainCategories =
                                                MainCategories.women;
                                          });

                                          homeProvider.setCategoryChildren(
                                              homeProvider
                                                  .categories![1].childes!);
                                        },
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Utils.mainCategories ==
                                                    MainCategories.women
                                                ? Colors.white
                                                : AppColors.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            homeProvider.categories![1].name!,
                                            style: TextStyle(
                                                color: Utils.mainCategories ==
                                                        MainCategories.women
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
                                            Utils.mainCategories =
                                                MainCategories.kids;
                                          });

                                          homeProvider.setCategoryChildren(
                                              homeProvider
                                                  .categories![2].childes!);
                                        },
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Utils.mainCategories ==
                                                    MainCategories.kids
                                                ? Colors.white
                                                : AppColors.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            homeProvider.categories![2].name!,
                                            style: TextStyle(
                                                color: Utils.mainCategories ==
                                                        MainCategories.kids
                                                    ? AppColors.primaryColor
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 4, 24, 60),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      l10n.categories,
                                      style: const TextStyle(
                                          fontFamily: 'Libre Baskerville',
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Utils.controller.jumpToTab(1);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          l10n.seeAll,
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///categories slider with left and right arrow buttons
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: -60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  _controller.previousPage(
                                      duration: const Duration(
                                    milliseconds: 200,
                                  ));
                                },
                                icon: Icon(
                                  l10n.localeName == 'en'
                                      ? Icons.keyboard_arrow_left_rounded
                                      : Icons.keyboard_arrow_right_rounded,
                                  //Icons.keyboard_arrow_left_rounded,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: CarouselSlider(
                                  items: imageSliders,
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      enlargeCenterPage: false,
                                      height: 110,
                                      viewportFraction: 0.34),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  _controller.nextPage(
                                      duration: const Duration(
                                    milliseconds: 200,
                                  ));
                                },
                                icon: Icon(
                                  l10n.localeName == 'en'
                                      ? Icons.keyboard_arrow_right_rounded
                                      : Icons.keyboard_arrow_left_rounded,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 60,
                    ),


                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        children: const [

                          MostWantedSection(),
                          SizedBox(height: 20),
                          ShopNowBanner(),
                          SizedBox(height: 20),
                          NewArrivalsSection(),

                        ],
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





