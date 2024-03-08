import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/features/my_bag/my_bag_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/notifications/notifications_screen.dart';
import 'package:labees/features/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    //required this.scaffoldKey,
    Key? key,
  }) : super(key: key);

  //final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.secondaryColor,
      leading: IconButton(
        onPressed: () {
          //widget.scaffoldKey.currentState!.openDrawer();
          _scaffoldkey.currentState?.openDrawer();
        },
        icon: SvgPicture.asset(
          Images.menuIcon,
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
    );
  }
}
