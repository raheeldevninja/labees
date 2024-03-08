import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/cart_product.dart';
import 'package:labees/core/models/payment_method.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/home_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 24 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: PaymentDetails
*/

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final _cardHolderNameController = TextEditingController();
  final _cardHolderNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _cvvController = TextEditingController();

  bool saveDetails = false;

  List<PaymentMethod> paymentMethods = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initPaymentMethods();
  }

  _initPaymentMethods() {
    paymentMethods.add(PaymentMethod(
        image:
            'https://labees-website.boedelipos.ch/assets/pay_method6-9a87f6a3.svg',
        isSelected: true));
    //paymentMethods.add(PaymentMethod(image: 'https://labees-website.boedelipos.ch/assets/pay_method7-e168a6d8.svg'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = context.watch<CheckoutProvider>();
    final cartProvider = context.watch<CartProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            '${l10n.paymentMethod}: ',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Libre Baskerville',
            ),
          ),
          const SizedBox(
            height: 40,
          ),

          //horizontal listview of payment methods
          SizedBox(
            height: 70,
            child: ListView.builder(
              itemCount: paymentMethods.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      for (var element in paymentMethods) {
                        element.isSelected = false;
                      }
                      paymentMethods[index].isSelected = true;
                    });
                  },
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: paymentMethods[index].isSelected
                            ? AppColors.primaryColor
                            : AppColors.lightGrey.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.network(paymentMethods[index].image),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          // Widgets.labels('Cardholder Name '),
          // const SizedBox(
          //   height: 10,
          // ),
          //
          // TextFormField(
          //   controller: _cardHolderNameController,
          //   maxLines: 1,
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: Colors.white,
          //     contentPadding: const EdgeInsets.all(12.0),
          //     hintText: 'Enter your name',
          //     hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(25.0),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          //       borderRadius: BorderRadius.circular(25.0),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide:
          //       const BorderSide(color: AppColors.primaryColor, width: 1.0),
          //       borderRadius: BorderRadius.circular(25.0),
          //     ),
          //   ),
          // ),
          //
          // const SizedBox(
          //   height: 10,
          // ),
          //
          // Widgets.labels('Cardholder Number '),
          // const SizedBox(
          //   height: 10,
          // ),
          //
          // TextFormField(
          //   controller: _cardHolderNumberController,
          //   maxLines: 1,
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: Colors.white,
          //     contentPadding: const EdgeInsets.all(12.0),
          //     hintText: 'Enter your card number',
          //     hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(25.0),
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          //       borderRadius: BorderRadius.circular(25.0),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide:
          //       const BorderSide(color: AppColors.primaryColor, width: 1.0),
          //       borderRadius: BorderRadius.circular(25.0),
          //     ),
          //   ),
          // ),
          //
          // const SizedBox(
          //   height: 20,
          // ),
          //
          // //date and cvv
          // Row(
          //   children: [
          //
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //
          //           Widgets.labels('Date ', isRequired: true),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //
          //           TextFormField(
          //             controller: _dateController,
          //             maxLines: 1,
          //             decoration: InputDecoration(
          //               filled: true,
          //               fillColor: Colors.white,
          //               contentPadding: const EdgeInsets.all(12.0),
          //               hintText: '10/25',
          //               hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(25.0),
          //               ),
          //               enabledBorder: OutlineInputBorder(
          //                 borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          //                 borderRadius: BorderRadius.circular(25.0),
          //               ),
          //               focusedBorder: OutlineInputBorder(
          //                 borderSide:
          //                 const BorderSide(color: AppColors.primaryColor, width: 1.0),
          //                 borderRadius: BorderRadius.circular(25.0),
          //               ),
          //             ),
          //           ),
          //
          //         ],
          //       ),
          //     ),
          //     const SizedBox(width: 16),
          //
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //
          //           Widgets.labels('CVV ', isRequired: true),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //
          //           TextFormField(
          //             controller: _cvvController,
          //             maxLines: 1,
          //             decoration: InputDecoration(
          //               filled: true,
          //               fillColor: Colors.white,
          //               contentPadding: const EdgeInsets.all(12.0),
          //               hintText: '000',
          //               hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(25.0),
          //               ),
          //               enabledBorder: OutlineInputBorder(
          //                 borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          //                 borderRadius: BorderRadius.circular(25.0),
          //               ),
          //               focusedBorder: OutlineInputBorder(
          //                 borderSide:
          //                 const BorderSide(color: AppColors.primaryColor, width: 1.0),
          //                 borderRadius: BorderRadius.circular(25.0),
          //               ),
          //             ),
          //           ),
          //
          //         ],
          //       ),
          //     ),
          //
          //   ],
          // ),
          //
          // const SizedBox(
          //   height: 20,
          // ),
          //
          // Row(
          //   children: [
          //     Checkbox(
          //       fillColor: MaterialStateProperty.all(AppColors.primaryColor),
          //       value: saveDetails,
          //       onChanged: (value) {
          //         setState(() {
          //           saveDetails = value!;
          //         });
          //       },
          //     ),
          //
          //     const Expanded(
          //       child: Text(
          //         'Save my payment details for future purchases',
          //         style: TextStyle(
          //           fontSize: 14,
          //           color: Colors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          //
          // const SizedBox(
          //   height: 50,
          // ),
          SizedBox(
            width: double.maxFinite,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                List<CartProduct> cartProducts =
                    await SharedPref.getCartProducts();

                //set payment method
                double vatPer =
                    (cartProvider.checkoutSettings.productTax! / 100) *
                        cartProvider.calculateSubTotal();

                final placeOrderModel =
                    checkoutProvider.getPlaceOrderModel.copyWith(
                  billingAddressId: checkoutProvider.getBillingAddressId,
                  addressId: checkoutProvider.getShippingAddressId,
                  cartProducts: cartProducts,
                  paymentMethod: 'cash_on_delivery',
                  shippingMethod: cartProvider.getSelectedShippingMethod()!.id,
                  isPartiallyPaid: 0,
                  partiallyWalletAmount: 0,
                  vat: cartProvider.checkoutSettings.productTax,
                  vatPrice: vatPer.toInt(),
                );

                checkoutProvider.setPlaceOrderModel(placeOrderModel);

                await checkoutProvider.placeOrder(placeOrderModel);

                if (checkoutProvider.placeOrderResponse!.status == 1) {
                  await SharedPref.clearCartProducts();

                  if (mounted) {
                    await context.read<CartProvider>().getCartProducts();
                  }

                  _showThankYouDialog(l10n);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
              child: Text(
                l10n.confirmBtnText,
              ),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  //show thank you dialog box
  Future<void> _showThankYouDialog(AppLocalizations l10n) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Center(
          child: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.thankYou,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              l10n.orderPlacedSuccess,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(l10n.okBtnText),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _cardHolderNameController.dispose();
    _cardHolderNumberController.dispose();
    _dateController.dispose();
    _cvvController.dispose();
  }
}
