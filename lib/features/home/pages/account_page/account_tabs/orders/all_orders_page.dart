import 'package:flutter/material.dart';
import 'package:labees/core/ui/order_item.dart';
import 'package:labees/core/ui/order_shimmer.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/order_provider.dart';
import 'package:labees/features/home/pages/account_page/widgets/order_cost_details_and_status.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 10 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: AllOrdersPage
*/

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final orderProvider = context.read<OrderProvider>();
      await orderProvider.getOrders(context, 'all', 10, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orderProvider = context.watch<OrderProvider>();

    if (orderProvider.isLoading) {
      return const OrdersShimmer();
    }

    if (orderProvider.ordersResponse.data != null &&
        orderProvider.ordersResponse.data!.isEmpty) {
      return Center(
        child: Text(l10n.noOrdersFound),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await orderProvider.getOrders(context, 'all', 10, 1);
      },
      child: ListView.builder(
        itemCount: orderProvider.ordersResponse.data!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      itemCount: orderProvider
                          .ordersResponse.data![index].details!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, productIndex) {
                        final product = orderProvider
                            .ordersResponse.data![index].details![productIndex];

                        return OrderItem(product: product);
                      },
                    ),
                    OrderCostDetailsAndStatus(
                        orderData: orderProvider.ordersResponse.data![index]),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                child: Row(
                  textDirection: l10n.localeName == 'en'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  children: [
                    Container(
                      width: 100,
                      height: 30,
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF5E6),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(width: 1, color: Colors.orange),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                          orderProvider
                              .ordersResponse.data![index].orderStatus!,
                          style: const TextStyle(color: Colors.orange)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
