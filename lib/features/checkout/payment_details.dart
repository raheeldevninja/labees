import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/cart_product.dart';
import 'package:labees/core/models/payment_method.dart';
import 'package:labees/core/ui/widgets.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/checkout/view_model/checkout_provider.dart';
import 'package:labees/features/home/home_screen.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/account_provider.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

/*
*  Date 21 - Mar-2024
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

  final _amountController = TextEditingController();

  bool saveDetails = false;

  List<PaymentMethod> paymentMethods = [];



  PaymentMethod selectedPaymentMethod = PaymentMethod(name: '', image: '');
  PaymentMethod selectedRemainingPaymentMethod = PaymentMethod(name: '', image: '');

  String? _paymentOption;

  List<PaymentMethod> remainingPaymentMethods = [];

  int isPartiallyPaid = 0;

  List<String> paymentMethodsValues = [
    'cash_on_delivery ',
    'pay_by_wallet',
    '',
    '',
    '',
  ];

  String selectedPaymentMethodValue = 'cash_on_delivery';



  late FlutterHyperPay flutterHyperPay ;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _paymentOption = 'Pay fully';
    _initPaymentMethods();

    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl: InAppPaymentSetting.shopperResultUrl, // return back to app
      paymentMode:  PaymentMode.test, // test or live
      lang: InAppPaymentSetting.getLang(),
    );



  }

  _initPaymentMethods() {

    paymentMethods.add(PaymentMethod(
      name: 'MADA',
      image:
      'https://labeesnew-website.boedelipos.ch/assets/pay_method5-5203d942.svg',
    ));

    paymentMethods.add(PaymentMethod(
      name: 'MASTER',
      image:
      'https://labeesnew-website.boedelipos.ch/assets/pay_method2-d27807ca.svg',
    ));

    paymentMethods.add(PaymentMethod(
      name: 'VISA',
      image:
      'https://labeesnew-website.boedelipos.ch/assets/pay_method3-64dbd443.svg',
    ));

    paymentMethods.add(PaymentMethod(
      name: 'Cash on Delivery',
        image:
            'https://labees-website.boedelipos.ch/assets/pay_method6-9a87f6a3.svg',
        isSelected: true));

    paymentMethods.add(PaymentMethod(
        name: 'Wallet',
        image: 'https://labees-website.boedelipos.ch/assets/pay_method7-e168a6d8.svg'));



    //remaining payment methods
    remainingPaymentMethods.add(PaymentMethod(
        name: 'Cash on Delivery',
        image:
        'https://labees-website.boedelipos.ch/assets/pay_method6-9a87f6a3.svg',
        isSelected: false,
    ));

  }

  getCheckOut(String brandName) async {
    final url = Uri.parse('https://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      log('checkout response: ${response.body}');

      payRequestNowReadyUI(
          checkoutId: json.decode(response.body)['id'],
          //brandsName: [ "VISA" , "MASTER" , "MADA" ,"PAYPAL", "STC_PAY" , "APPLEPAY"]
          brandsName: [ brandName ]
      );
    } else {
      dev.log(response.body.toString(), name: "STATUS CODE ERROR");
    }
  }



  payRequestNowReadyUI(
      {required List<String> brandsName, required String checkoutId}) async {
    PaymentResultData paymentResultData;
    paymentResultData = await flutterHyperPay.readyUICards(
      readyUI: ReadyUI(
          brandsName: brandsName ,
          checkoutId: checkoutId,
          merchantIdApplePayIOS: InAppPaymentSetting.merchantId,
          countryCodeApplePayIOS: InAppPaymentSetting.countryCode,
          companyNameApplePayIOS: "Test Co",
          themColorHexIOS: "#000000" ,// FOR IOS ONLY
          setStorePaymentDetailsMode: true // store payment details for future use
      ),
    );


    log('paymentResultData: ${paymentResultData.paymentResult}');

    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something

      print('success status');





    }
  }

  //disable pay fully pay partially radio buttons if wallet balance is less than total amount
  bool isWalletBalanceLessThanTotalAmount() {
    final accountProvider = context.read<AccountProvider>();
    final cartProvider = context.read<CartProvider>();

    if(accountProvider.walletResponse.totalWalletBalance! < cartProvider.calculateSubTotal()) {
      return true;
    }


    return false;
  }

  //check if wallet balance is zero
  bool isWalletBalanceZero() {
    final accountProvider = context.read<AccountProvider>();

    if(accountProvider.walletResponse.totalWalletBalance! == 0) {
      return true;
    }

    return false;
  }



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final checkoutProvider = context.watch<CheckoutProvider>();
    final cartProvider = context.watch<CartProvider>();
    final accountProvider = context.watch<AccountProvider>();



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
            height: 60,
            child: ListView.builder(
              itemCount: paymentMethods.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {

                print('paymentMethods[index].name: ${paymentMethods[index].image}');

                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                   onTap: () {

                     for (var element in paymentMethods) {
                       element.isSelected = false;
                     }
                     paymentMethods[index].isSelected = true;

                     selectedPaymentMethod = paymentMethods[index];

                     selectedPaymentMethodValue = paymentMethodsValues[index];

                     setState(() {});

                     if(paymentMethods[index].name != 'Wallet' && paymentMethods[index].name != 'Cash on Delivery') {
                       getCheckOut(paymentMethods[index].name);
                     }

                  },
                  child: Container(
                    width: 120,
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
                    child: SvgPicture.network(paymentMethods[index].image),
                  ),
                );
              },
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          if(selectedPaymentMethod.name == 'Wallet') ...[
            Text('Your current balance: SAR ${accountProvider.walletResponse.totalWalletBalance}'),

            //pay fully pay partially radio buttons
            Row(
              children: [
                Radio(
                  fillColor: isWalletBalanceZero() || isWalletBalanceLessThanTotalAmount() ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(AppColors.primaryColor),
                  value: 'Pay fully',
                  groupValue: _paymentOption,
                  onChanged: isWalletBalanceZero() || isWalletBalanceLessThanTotalAmount() ? null : (value) {

                    setState(() {
                      _paymentOption = value as String;
                      isPartiallyPaid = 0;
                    });

                  },
                ),
                Text(l10n.payFullyLabel, style: TextStyle(color: isWalletBalanceZero() || isWalletBalanceLessThanTotalAmount() ? Colors.grey : Colors.black),),
                const SizedBox(width: 16),
                Radio(
                  fillColor: isWalletBalanceZero() ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(AppColors.primaryColor),
                  value: 'Pay partially',
                  groupValue: _paymentOption,
                  onChanged: isWalletBalanceZero() ? null : (value) {
                    setState(() {
                      _paymentOption = value as String;
                      isPartiallyPaid = 1;
                    });
                  },
                ),
                Text(l10n.payPartiallyLabel, style: TextStyle(color: isWalletBalanceZero() ? Colors.grey : Colors.black),),
              ],
            ),


            const SizedBox(
              height: 20,
            ),

            if(_paymentOption == 'Pay partially') ...[
              Widgets.labels('${l10n.enterAmountLabel} '),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _amountController,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(12.0),
                  hintText: l10n.enterAmountHint,
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: AppColors.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Widgets.labels('${l10n.payRemainingWith} ', isRequired: false),

              const SizedBox(
                height: 10,
              ),


              ///remaining payment methods
              SizedBox(
                height: 70,
                child: ListView.builder(
                  itemCount: remainingPaymentMethods.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {

                    if(remainingPaymentMethods[index].name == 'Wallet') {
                      return Container();
                    }


                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          for (var element in remainingPaymentMethods) {
                            element.isSelected = false;
                          }
                          remainingPaymentMethods[index].isSelected = true;
                          selectedRemainingPaymentMethod = remainingPaymentMethods[index];

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
                            color: remainingPaymentMethods[index].isSelected
                                ? AppColors.primaryColor
                                : AppColors.lightGrey.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.network(remainingPaymentMethods[index].image),
                        ),
                      ),
                    );
                  },
                ),
              ),


            ],




          ],


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

                final placeOrderModel = checkoutProvider.getPlaceOrderModel.copyWith(
                  billingAddressId: checkoutProvider.getBillingAddressId,
                  addressId: checkoutProvider.getShippingAddressId,
                  cartProducts: cartProducts,
                  paymentMethod: selectedPaymentMethodValue,
                  shippingMethod: cartProvider.getSelectedShippingMethod()!.id,
                  isPartiallyPaid: isPartiallyPaid,
                  partiallyWalletAmount: isPartiallyPaid == 1 ? int.parse(_amountController.text) : 0,
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

    _amountController.dispose();

    _cardHolderNameController.dispose();
    _cardHolderNumberController.dispose();
    _dateController.dispose();
    _cvvController.dispose();
  }
}


class InAppPaymentSetting {
  static const String shopperResultUrl= "com.testpayment.payment";
  static const String merchantId= "MerchantId";
  static const String countryCode="SA";
  static getLang() {
    if (Platform.isIOS) {
      return  "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}