import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/account_provider.dart';
import 'package:labees/features/home/pages/account_page/model/transaction.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/features/home/pages/account_page/widgets/wallet_point_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: WalletTab
*/

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();

    //_initTransactions();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountProvider>().getWalletList(context, 10, 1);
    });
  }

  _initTransactions() {
    transactions.add(Transaction(
        productName: 'T-Shirt',
        brand: 'Nike',
        price: 100,
        paymentStatus: 'Paid',
        discount: 5,
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png',
        transactionType: 'Credit'));

    transactions.add(Transaction(
        productName: 'T-Shirt',
        brand: 'Nike',
        price: 100,
        paymentStatus: 'UnPaid',
        discount: 5,
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png',
        transactionType: 'Credit'));

    transactions.add(Transaction(
        productName: 'T-Shirt',
        brand: 'Nike',
        price: 100,
        paymentStatus: 'Paid',
        discount: 5,
        image:
            'https://labees.mydomain101.net/storage/app/public/product/thumbnail/2023-07-14-64b11bfec27c5.png',
        transactionType: 'Credit'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final accountProvider = context.watch<AccountProvider>();

    return accountProvider.getLoading ? const WalletPointShimmer() : RefreshIndicator(
      onRefresh: () async {
        await accountProvider.getWalletList(context, 10, 1);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.myWalletHeading,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Libre Baskerville',
              ),
            ),


            ///balance value
            // const SizedBox(
            //   height: 16,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       l10n.balanceHeading,
            //       style: const TextStyle(
            //         fontSize: 18,
            //         fontFamily: 'Libre Baskerville',
            //       ),
            //     ),
            //     Row(
            //       mainAxisSize: MainAxisSize.min,
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         const Text(
            //           'SAR',
            //           style: TextStyle(
            //             fontSize: 12,
            //             fontFamily: 'Montserrat',
            //           ),
            //         ),
            //         const SizedBox(width: 8),
            //         Text(
            //           accountProvider.walletResponse.totalWalletBalance?.toStringAsFixed(2) ?? '0.00',
            //           style: const TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: 'Montserrat',
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),

            const SizedBox(
              height: 20,
            ),

            Text(
              l10n.transactionsLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            //transactions listview.builder,
            Expanded(
              child: ListView.builder(
                itemCount:
                    accountProvider.walletResponse.walletTransactioList!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  //return WalletItem(transaction: transactions[index]);

                  final transaction =
                      accountProvider.walletResponse.walletTransactioList![index];
                  transaction.transactionType = transaction.transactionType!
                      .split('_')
                      .map((e) => e[0].toUpperCase() + e.substring(1))
                      .join(' ');

                  final date = DateTime.parse(transaction.createdAt!);
                  final formattedDate =
                      '${Utils.monthNumToName(date.month)} ${date.day}, ${date.year}';

                  // return Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           flex: 2,
                  //           child: Text(
                  //             transaction.transactionType!,
                  //             style: const TextStyle(color: Colors.black),
                  //             textAlign: TextAlign.left,
                  //           )),
                  //       Expanded(
                  //           child: Text(
                  //         'SAR ${transaction.credit!.toString()}',
                  //         style: const TextStyle(color: Colors.black),
                  //         textAlign: TextAlign.center,
                  //       )),
                  //       Expanded(
                  //           child: Text(
                  //         'SAR ${transaction.debit!.toString()}',
                  //         style: const TextStyle(color: Colors.black),
                  //         textAlign: TextAlign.center,
                  //       )),
                  //       Expanded(
                  //           flex: 2,
                  //           child: Text(
                  //             formattedDate,
                  //             style: const TextStyle(color: Colors.black),
                  //             textAlign: TextAlign.center,
                  //           )),
                  //     ],
                  //   ),
                  // );

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
                                        style:
                                        TextStyle(color: Colors.black),
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
                                  const Text(
                                    'Loyalty Point ',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Balance',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${transaction.balance} SAR',
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
                                        style:
                                        TextStyle(color: Colors.black),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Text(
                                      transaction.credit!
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
                                color: AppColors.lightGrey.withOpacity(0.8),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Debit: ',
                                        style:
                                        TextStyle(color: Colors.black),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Text(
                                      transaction.debit!
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
}

class WalletItem extends StatelessWidget {
  const WalletItem({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: AppColors.borderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  transaction.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${transaction.transactionType}: ',
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  transaction.productName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  transaction.brand,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.price} SAR',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  color: AppColors.primaryColor,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              //rounded border container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: transaction.paymentStatus.toLowerCase() == 'paid'
                      ? AppColors.green.withOpacity(0.6)
                      : AppColors.red.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: transaction.paymentStatus.toLowerCase() == 'paid'
                        ? AppColors.green
                        : AppColors.red,
                  ),
                ),
                child: Text(
                  transaction.paymentStatus.toLowerCase() == 'paid'
                      ? 'Paid'
                      : 'Not Paid',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              Text(
                '${transaction.discount.toInt()} % Discount',
                style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


