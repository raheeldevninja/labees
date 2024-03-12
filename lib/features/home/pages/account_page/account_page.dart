import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/features/auth/login_register/login_register_widget.dart';
import 'package:labees/features/auth/view_model/auth_provider.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/account_tab.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/my_address_tab.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/orders/my_orders_tab.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/news_letter_tab.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/points_tab.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/wallet_tab.dart';
import 'package:labees/features/home/widgets/app_drawer.dart';
import 'package:labees/features/notifications/notifications_screen.dart';
import 'package:labees/features/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 9 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: Account Page
*/

class AccountPage extends StatefulWidget {
  const AccountPage({
    required this.initialIndex,
    Key? key}) : super(key: key);

  final int initialIndex;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  late TabController _tabController;

  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();



    _tabController =

        TabController(initialIndex: widget.initialIndex, length: 6, vsync: this); // Set the number of tabs
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
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
        bottom: authProvider.isLoggedIn
            ? TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                isScrollable: true,
                indicatorColor: AppColors.primaryColor,
                indicatorWeight: 6,
                tabs: [
                  Tab(text: l10n.accountTab),
                  Tab(text: l10n.myAddressTab),
                  Tab(text: l10n.myOrders),
                  Tab(text: l10n.newLetterTab),
                  Tab(text: l10n.walletTab),
                  Tab(text: l10n.pointsTab),
                ],
              )
            : null,
        actions: [
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
      drawer: const AppDrawer(),
      //body: const LoginRegisterWidget(),
      body: authProvider.isLoggedIn
          ? TabBarView(
              controller: _tabController,
              children: const [
                AccountTab(),
                MyAddressTab(),
                MyOrdersTab(),
                NewsLetterTab(),
                WalletTab(),
                PointsTab(),
              ],
            )
          : const LoginRegisterWidget(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
    _tabController.dispose();
  }
}
