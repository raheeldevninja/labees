import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/account_provider.dart';
import 'package:labees/features/home/pages/account_page/model/point_model.dart';
import 'package:labees/features/home/pages/account_page/widgets/wallet_point_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointsTab extends StatefulWidget {
  const PointsTab({Key? key}) : super(key: key);

  @override
  State<PointsTab> createState() => _PointsTabState();
}

class _PointsTabState extends State<PointsTab> {
  List<PointModel> points = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AccountProvider>().getMyPoints(context, 10, 1);

      if (mounted) {
        await context.read<AccountProvider>().getAccountSettings(context);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final accountProvider = context.watch<AccountProvider>();

    if (accountProvider.myPointsResponse == null) {
      return const SizedBox();
    }

    return accountProvider.getLoading
        ? const WalletPointShimmer()
        : RefreshIndicator(
            onRefresh: () async {
              await accountProvider.getMyPoints(context, 10, 1);
              await accountProvider.getAccountSettings(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                //padding: const EdgeInsets.all(16),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.pointsHeading,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Libre Baskerville',
                        ),
                      ),
                      Text(
                        accountProvider.myPointsResponse?.totalLoyaltyPoint
                                ?.toStringAsFixed(2) ??
                            '0.00',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Libre Baskerville',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    l10n.getLoyaltyPoints,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  ///convert to currency
                  InkWell(
                    onTap: () {
                      _showConvertToCurrencyDialog(
                          context, accountProvider, l10n);
                    },
                    child: Container(
                      width: 180,
                      height: 50,
                      //padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          l10n.convertToCurrencyBtnText,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Libre Baskerville',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //points listview
                  Expanded(
                    child: ListView.builder(
                      itemCount: accountProvider
                          .myPointsResponse?.loyaltyPointList!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final loyaltyPoint = accountProvider
                            .myPointsResponse!.loyaltyPointList![index];

                        loyaltyPoint.transactionType = loyaltyPoint
                            .transactionType!
                            .split('_')
                            .map((e) => e[0].toUpperCase() + e.substring(1))
                            .join(' ');

                        final date = DateTime.parse(loyaltyPoint.createdAt!);
                        final formattedDate =
                            '${Utils.monthNumToName(date.month)} ${date.day}, ${date.year}';

                        final expiryDate = DateTime.parse(loyaltyPoint.expiry!);
                        final formattedExpiryDate =
                            '${Utils.monthNumToName(expiryDate.month)} ${expiryDate.day}, ${expiryDate.year}';

                        /*return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              loyaltyPoint.transactionType!,
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.left,
                            )),
                        Expanded(
                            child: Text(
                              'SAR ${loyaltyPoint.credit!.toString()}',
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            child: Text(
                              'SAR ${loyaltyPoint.debit!.toString()}',
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              formattedDate,
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              loyaltyPoint.credit! == 0
                                  ? 'N/A'
                                  : formattedExpiryDate,
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )),
                        Expanded(
                          child: Text(
                            loyaltyPoint.credit! == 0 ? 'N/A' : 'Available',
                            style: TextStyle(
                                color: loyaltyPoint.credit == 0
                                    ? Colors.black
                                    : Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );*/

                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.lightGrey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              //first row
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Date: ',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              formattedDate,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),

                                        //expiry date
                                        Row(
                                          children: [
                                            const Text(
                                              'Expiry Date: ',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              loyaltyPoint.credit! == 0
                                                  ? 'N/A'
                                                  : formattedExpiryDate,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 4),
                                        const Text(
                                          'Point to Wallet ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Balance',
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${loyaltyPoint.balance} Points ',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 6),
                                child: Divider(
                                  color: AppColors.lightGrey.withOpacity(0.2),
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'Credit: ',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Text(
                                            loyaltyPoint.credit!
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color:
                                          AppColors.lightGrey.withOpacity(0.8),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'Debit: ',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Text(
                                            loyaltyPoint.debit!
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  ///convert to currency dialog
  Future<bool?> _showConvertToCurrencyDialog(BuildContext context,
      AccountProvider accountProvider, AppLocalizations l10n) {
    final pointsController = TextEditingController();

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.convertCurrencyTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(l10n.convertCurrencyDesc),
                const SizedBox(height: 20),
                Text(
                    '${l10n.minPoints} ${accountProvider.accountSettingsResponse.loyaltyPointMinimumPoint} ${l10n.points}',
                    style: const TextStyle(color: Colors.orange)),
                const SizedBox(height: 20),
                Text(
                    '${accountProvider.accountSettingsResponse.loyaltyPointExchangeRate} ${l10n.points} = 1 SAR'),
                const SizedBox(height: 20),
                TextField(
                  controller: pointsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.enterPointsHint,
                    hintText: l10n.enterPointsHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            //cancel
            TextButton(
              child: Text(l10n.cancelBtnText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),

            TextButton(
              child: Text(l10n.submitBtnText),
              onPressed: () async {
                await accountProvider.convertToCurrency(
                    context, int.parse(pointsController.text.trim()));
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
