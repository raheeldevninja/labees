import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/faqs/faqs_screen.dart';
import 'package:labees/features/my_bag/my_bag_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/notifications/notifications_screen.dart';
import 'package:labees/features/seller/seller_home_screen.dart';
import 'package:labees/features/settings/settings_screen.dart';
import 'package:labees/features/support_ticket/support_ticket_lists_screen.dart';
import 'package:labees/features/support_ticket/support_ticket_screen.dart';
import 'package:labees/features/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loginStatus = authProvider.isLoggedIn;

    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: Colors.white,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context,
                    color: Colors.white, width: 0),
              ),
            ),
            padding: const EdgeInsets.all(24),
            margin: EdgeInsets.zero,
            child: SvgPicture.asset(
              Images.drawerLogo,
              width: 40,
              height: 40,
            ),
          ),
          _buildNavDrawerItem(
            l10n.home,
            Images.homeIcon,
            () {
              Navigator.pop(context);
              Utils.controller.jumpToTab(0);
            },
          ),
          _buildNavDrawerItem(
            l10n.categories,
            Images.drawerCategories,
            () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);

              final user = await authProvider.getUser();
              final token = await authProvider.getToken();

              if (user != null) {
                debugPrint('token: $token');
                debugPrint('user: ${user.fName} ${user.lName}');
              }

              Navigator.pop(context);
              Utils.controller.jumpToTab(1);
            },
          ),

          _buildNavDrawerItem(
            l10n.designers,
            Images.drawerDesigners,
            () {
              Navigator.pop(context);
              Utils.controller.jumpToTab(2);
            },
          ),

          _buildNavDrawerItem(
            l10n.account,
            Images.drawerAccount,
            () {
              Navigator.pop(context);
              Utils.controller.jumpToTab(3);
            },
          ),

          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.drawerIconBgColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: SvgPicture.asset(
                Images.drawerWishlist,
              ),
            ),
            title: Text(l10n.wishlistTitle),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistScreen(),
                ),
              );
            },
          ),

          _buildNavDrawerItem(
            l10n.bag,
            Images.drawerBag,
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyBagScreen(),
                ),
              );
            },
          ),

          _buildNavDrawerItem(
            l10n.myOrders,
            Images.drawerMyOrders,
            () {
              Navigator.pop(context);
            },
          ),

          _buildNavDrawerItem(
            l10n.notifications,
            Images.drawerNotifications,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),

          _buildNavDrawerItem(
            l10n.settings,
            Images.drawerSettings,
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),

          _buildNavDrawerItem(
            l10n.faq,
            Images.faqIcon,
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FAQScreen(),
                ),
              );
            },
          ),

          ///ticket support
          _buildNavDrawerItem(
            l10n.supportTicket,
            Images.supportTicketIcon,
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TicketSupportListsScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.drawerIconBgColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: const Icon(Icons.sell, color: AppColors.primaryColor),
            ),
            title: Text(l10n.registerAsSeller),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellerHomeScreen(),
                ),
              );
            },
          ),

          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 160,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 60),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    if (loginStatus) {
                      authProvider.setLoginStatus(false);
                      await authProvider.logout();
                      await SharedPref.clear();

                      context.read<CartProvider>().getCartProducts();
                    } else {
                      //navigate to accounts and show login / register screen if user is not logged in
                      Utils.controller.jumpToTab(3);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: Colors.transparent,
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
                      SvgPicture.asset(
                        Images.logoutIcon,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        loginStatus ? l10n.logout : l10n.login,
                        style: const TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  ListTile _buildNavDrawerItem(
    String text,
    String icon,
    VoidCallback callback,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppColors.drawerIconBgColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: SvgPicture.asset(
          icon,
        ),
      ),
      title: Text(text),
      onTap: callback,
    );
  }
}
