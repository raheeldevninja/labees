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

    //_initPoints();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountProvider>().getMyPoints(context, 10, 1);
      context.read<AccountProvider>().getAccountSettings(context);
    });
  }

  _initPoints() {
    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));

    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));

    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));

    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));
    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));
    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));
    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));
    points.add(PointModel(
      productName: 'T-Shirt',
      brand: 'Nike',
      point: 10,
      date: '2021-07-14',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accountProvider = context.watch<AccountProvider>();

    return accountProvider.getLoading ? const WalletPointShimmer() : Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        //padding: const EdgeInsets.all(16),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: l10n.localeName == 'en'
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {

                  _showConvertToCurrencyDialog(context, accountProvider, l10n);

                },
                child: Container(
                  width: 180,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
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
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

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
                accountProvider.myPointsResponse.totalLoyaltyPoint!
                    .toStringAsFixed(2),
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

          ///points list header
          Container(
            height: 50,
            color: AppColors.primaryColor,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      l10n.tranTypeLabel,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: Text(
                      l10n.creditLabel,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: Text(
                      l10n.debitLabel,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: Text(
                      l10n.dateLabel,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: Text(
                      l10n.expDateLabel,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: Text(
                      l10n.statusLabel,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),

          //points listview
          Expanded(
            child: ListView.builder(
              itemCount:
              accountProvider.myPointsResponse.loyaltyPointList!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final loyaltyPoint =
                accountProvider.myPointsResponse.loyaltyPointList![index];

                loyaltyPoint.transactionType = loyaltyPoint.transactionType!
                    .split('_')
                    .map((e) => e[0].toUpperCase() + e.substring(1))
                    .join(' ');

                final date = DateTime.parse(loyaltyPoint.createdAt!);
                final formattedDate =
                    '${Utils.monthNumToName(date.month)} ${date.day}, ${date
                    .year}';

                final expiryDate = DateTime.parse(loyaltyPoint.expiry!);
                final formattedExpiryDate =
                    '${Utils.monthNumToName(expiryDate.month)} ${expiryDate
                    .day}, ${expiryDate.year}';

                return Padding(
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
                );

              },
            ),
          ),
        ],
      ),
    );
  }

  ///convert to currency dialog
  Future<bool?> _showConvertToCurrencyDialog(BuildContext context, AccountProvider accountProvider, AppLocalizations l10n) {


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
                Text('${l10n.minPoints} ${accountProvider.accountSettingsResponse.loyaltyPointMinimumPoint} ${l10n.points}', style: const TextStyle(color: Colors.yellow)),
                const SizedBox(height: 20),
                Text('${accountProvider.accountSettingsResponse.loyaltyPointExchangeRate} ${l10n.points} = 1 SAR'),
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

                await accountProvider.convertToCurrency(context, int.parse(pointsController.text.trim()));
                Navigator.of(context).pop(false);

              },
            ),
          ],
        );
      },
    );
  }



}