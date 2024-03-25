import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/pages/account_page/account_page.dart';
import 'package:labees/features/home/pages/categories_page/categories_page.dart';
import 'package:labees/features/home/pages/designers_page.dart';
import 'package:labees/features/home/pages/home_page/home_page.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pages/account_page/account_tabs/view_model/account_provider.dart';

/*
*  Date 9 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Home Screen
*/

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      APIs.token = await SharedPref.getToken();

      log('token: ${APIs.token}');

      if (mounted) {

        await Future.wait([
          context.read<CartProvider>().getCartProducts(),
          context.read<CartProvider>().getShippingMethods(context),
          context.read<CartProvider>().getCheckoutSettings(context),
          context.read<CheckoutProvider>().getCountries(context),
          context.read<CheckoutProvider>().getAllAddresses(context),
          //context.read<AccountProvider>().getWalletList(context, 10, 1),
        ]);




      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      //controller: _controller,
      controller: Utils.controller,
      navBarHeight: 70,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: false,

      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: null,
      /*ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),*/
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const CategoriesPage(),
      const DesignersPage(),
      const AccountPage(initialIndex: 0),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final l10n = AppLocalizations.of(context)!;

    return [
      _buildBottomNavBarItem(icon: Images.homeIcon, title: l10n.home),
      _buildBottomNavBarItem(
          icon: Images.categoriesIcon, title: l10n.categories),
      _buildBottomNavBarItem(icon: Images.designersIcon, title: l10n.designers),
      _buildBottomNavBarItem(icon: Images.accountIcon, title: l10n.account),
    ];
  }

  PersistentBottomNavBarItem _buildBottomNavBarItem(
      {required String icon, required String title}) {
    return PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        icon,
        color: AppColors.activeIcon,
      ),
      inactiveIcon: SvgPicture.asset(
        icon,
        color: AppColors.inactiveIcon,
      ),
      title: title,
      activeColorPrimary: AppColors.activeIcon,
      inactiveColorPrimary: AppColors.inactiveIcon,
    );
  }
}
