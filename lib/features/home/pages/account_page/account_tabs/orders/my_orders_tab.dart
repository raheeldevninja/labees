import 'package:flutter/material.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/pages/account_page/widgets/no_orders_widget.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/orders/orders_main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



/*
*  Date 10 - Now-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: My Orders Tab
*/


class MyOrdersTab extends StatefulWidget {
  const MyOrdersTab({Key? key}) : super(key: key);

  @override
  State<MyOrdersTab> createState() => _MyOrdersTabState();
}

class _MyOrdersTabState extends State<MyOrdersTab> {

  @override
  void initState() {
    super.initState();

    Utils.initOrders();
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.myOrdersHeading,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Libre Baskerville',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Utils.myOrders.isEmpty
              ? const NoOrdersWidget()
              : const OrdersMainPage(),

          const SizedBox(height: 40,),

        ],
      ),
    );
  }
}
