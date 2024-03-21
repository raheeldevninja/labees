import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/ui/summary_sheet.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/checkout/information.dart';
import 'package:labees/features/checkout/payment_details.dart';
import 'package:labees/features/checkout/shipping_address.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/account_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 2 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: CheckoutScreen
*/

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String step = 'information';

  int currentPage = 0;

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CheckoutProvider>().getAllAddresses();

    });

    Utils.pageController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {


        context.read<AccountProvider>().getWalletList(context, 10, 1);

        if (mounted) {
          setState(() {
            Utils.currentPage = Utils.pageController.page!.round();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            if (Utils.currentPage >= 1) {
              Utils.pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn);
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          l10n.checkoutTitle,
          style: const TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  //steps
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  Images.accountIcon,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(l10n.informationTab,
                                  style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  Images.truckIcon,
                                  width: 20,
                                  height: 20,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(l10n.shippingDetailsTab,
                                  style: TextStyle(
                                      color: Utils.currentPage == 1.0
                                          ? AppColors.primaryColor
                                          : AppColors.lightGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  Images.cardIcon,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(l10n.paymentTab,
                                  style: const TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  //progress
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                      Container(
                        width: currentPage == 0
                            ? 100
                            : currentPage == 1
                                ? 230
                                : double.maxFinite,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: PageView(
                controller: Utils.pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: const [
                  Information(),
                  ShippingAddress(),
                  PaymentDetails(),
                ],
              ),
            ),
            const SummarySheet(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
