import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/coupon_data.dart';
import 'package:labees/core/models/shipping_method.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 3 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: SummarySheet
*/

class SummarySheet extends StatefulWidget {
  const SummarySheet({Key? key}) : super(key: key);

  @override
  State<SummarySheet> createState() => _SummarySheetState();
}

class _SummarySheetState extends State<SummarySheet> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  final _couponCodeController = TextEditingController();
  final List<String> shipping = [
    'Standard Shipping - Sar 25',
    'Express - Sar 50'
  ];
  String? selectedValue;

  CouponData? couponData;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cartProvider = context.read<CartProvider>();
      cartProvider.setSelectShippingMethod(
          context.read<CartProvider>().getShippingMethodsList.first);


      couponData = await SharedPref.getCouponData();

      if (couponData != null) {
        _couponCodeController.text = couponData!.code!;
      }


    });
  }

  void _onChanged() {
    final currentSize = _controller.size;
    //if (currentSize <= 0.05) _collapse();
  }

  /*void _collapse() => _animateSheet(sheet.snapSizes!.first);
  void _anchor() => _animateSheet(sheet.snapSizes!.last);*/

  void _expand() => _animateSheet(sheet.maxChildSize);

  void _hide() => _animateSheet(sheet.minChildSize);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  DraggableScrollableSheet get sheet =>
      (_sheet.currentWidget as DraggableScrollableSheet);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cartProvider = context.watch<CartProvider>();

        double subTotal = cartProvider.calculateSubTotal();

        String discountType = '';
        String discountSymbol = '';

        if (cartProvider.applyCouponResponse != null &&
            cartProvider.applyCouponResponse!.data != null) {
          discountType =
              cartProvider.applyCouponResponse!.data!.coupon!.discountType!;

          //cartProvider.calculateCouponDiscount();
          discountSymbol = '';

          if (discountType == 'percentage') {
            discountSymbol = '%';
          } else {
            discountSymbol = 'Sar';
          }
        }

        return DraggableScrollableSheet(
          key: _sheet,
          initialChildSize: 0.05,
          maxChildSize: 0.7,
          minChildSize: 0.05,
          expand: true,
          snap: false,
          controller: _controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return cartProvider.selectedShippingMethod == null
                ? const SizedBox()
                : DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.bgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: 6,
                                  width: 40,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.orderSummary,
                                      style: const TextStyle(
                                          fontFamily: 'Libre Baskerville',
                                          fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    TextFormField(
                                      controller: _couponCodeController,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.all(12.0),
                                        hintText: l10n.couponCode,
                                        hintStyle: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            cartProvider.applyCoupon(
                                                _couponCodeController.text
                                                    .trim(),
                                                subTotal.toInt(),
                                                cartProvider
                                                    .selectedShippingMethod!
                                                    .cost!);
                                          },
                                          child: Container(
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              l10n.applyBtnText,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColors.primaryColor,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      l10n.shippingLabel,
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 10),

                                    DropdownButtonFormField<ShippingMethod>(
                                      //value: selectedValue,
                                      value: cartProvider
                                          .getSelectedShippingMethod(),
                                      hint: const Text('Select Shipping'),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      //items: shipping.map((String item) {
                                      items: cartProvider.shippingMethodsList
                                          .map((ShippingMethod item) {
                                        return DropdownMenuItem<ShippingMethod>(
                                          value: item,
                                          child: Text(
                                              '${item.title!} - Sar ${item.cost}'),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        /*setState(() {
                                    selectedValue = value;
                                  });*/

                                        cartProvider
                                            .setSelectShippingMethod(value!);
                                      },
                                    ),

                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          l10n.subTotalLabel,
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Sar $subTotal',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cartProvider
                                              .selectedShippingMethod!.title!,
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Sar ${cartProvider.selectedShippingMethod!.cost}',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),

                                    if (cartProvider.applyCouponResponse !=
                                            null &&
                                        cartProvider
                                                .applyCouponResponse!.data !=
                                            null) ...[
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${l10n.coupon}: ${cartProvider.applyCouponResponse!.data!.coupon!.discount} $discountSymbol Off',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            //'Sar ${cartProvider.couponDiscount}',
                                            'Sar ${cartProvider.applyCouponResponse!.data!.couponDiscount}',
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],

                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${l10n.vatLabel} on items',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${cartProvider.checkoutSettings.productTax} % ${l10n.vatLabel}',
                                              style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            /*Text(
                                        'Vat Inclusive ',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),*/
                                          ],
                                        ),
                                        Text(
                                          'Sar ${(cartProvider.checkoutSettings.productTax! / 100) * subTotal}',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    //delivery vat
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Delivery VAT',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Sar ${(cartProvider.checkoutSettings.productTax! / 100) * cartProvider.selectedShippingMethod!.cost!}',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),

                                    const Divider(),

                                    const SizedBox(height: 10),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${l10n.totalLabel} ',
                                              style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            /*Text(
                                        '${l10n.vatInclusive} ',
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),*/
                                          ],
                                        ),
                                        Text(
                                          'Sar ${subTotal + cartProvider.selectedShippingMethod!.cost! + (cartProvider.checkoutSettings.productTax! / 100 * subTotal) + cartProvider.couponDiscount + (cartProvider.checkoutSettings.productTax! / 100) * cartProvider.selectedShippingMethod!.cost!}',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
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
        );
      },
    );
  }
}
