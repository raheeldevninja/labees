import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:labees/core/models/orders_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/order_provider.dart';
import 'package:provider/provider.dart';


/*
*  Date 19 - Dec-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: OrderCostDetailsAndStatus
*/

class OrderCostDetailsAndStatus extends StatelessWidget {
  OrderCostDetailsAndStatus({
    required this.orderData,
    Key? key}) : super(key: key);

  final OrderData orderData;

  final _reasonController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);
    final orderProvider = context.watch<OrderProvider>();

    return Column(
      children: [

        ///sub total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${l10n.subTotalLabel} ',
              style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            Text(
              '${orderData.summary!.subtotal} Sar ',
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),

        ///shipping cost
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${l10n.shippingLabel}: ',
              style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            Text(
              '${orderData.summary!.totalShippingCost} Sar ',
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),

        ///discount
        if(orderData.summary!.totalDiscountOnProduct! > 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${l10n.couponDiscountLabel}: ',
                style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
              ),
              Text(
                '${orderData.summary!.totalDiscountOnProduct} Sar ',
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),

        ],

        ///vat
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${l10n.vatLabel}: ${orderData.vat} %',
              style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            Text(
              '${orderData.summary!.subtotal! * (orderData.vat! / 100)} Sar ',
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),

        const Divider(),

        ///grand total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${l10n.totalLabel}: ',
              style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            Text(
              '${(orderData.summary!.subtotal! + orderData.summary!.totalShippingCost! + (orderData.summary!.subtotal! * orderData.vat! / 100)) - orderData.summary!.totalDiscountOnProduct! } Sar ',
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),

        const SizedBox(height: 16),

        ///cancel order and track order button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            ///cancel order button
            orderData.orderStatus == 'pending' &&  orderData.paymentStatus == 'unpaid'

                ? TextButton(
              onPressed: () {

                Utils.showCancelOrderDialog(
                  context,
                  orderData.id!,
                  l10n,
                  orderProvider,
                  _reasonController,
                );

              },
              child: Text(
                l10n.cancelOrderBtnText,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ) : const SizedBox(),

            ///track order button
            SizedBox(
              height: 35,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Images.trackIcon,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.trackOrderBtnText,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///review
        Row(
          children: [

            //add review button
            //orderData.orderStatus == 'delivered' && orderData.paymentStatus == 'paid'
            orderData.paymentStatus == 'paid'
                ? TextButton(
              onPressed: () async {

                //orderProvider.addReview(productId, comment, rating);
                _showRatingAndCommentDialog(context);
              },
              child: Text(
                'Add Review',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ) : const SizedBox(),

          ],
        ),

      ],
    );
  }

  //rating and comment dialog
  void _showRatingAndCommentDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    double ratingValue = 0.0;
    final reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Rating and Review',
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  ratingValue = rating;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add Review',
                  hintStyle: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                l10n.cancelBtnText,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {

                await orderProvider.addReview(orderData.id!, reviewController.text.trim(), ratingValue);

                if(orderProvider.addReviewResponse.status!) {
                  Navigator.pop(context);
                }

              },
              child: Text(
                l10n.submitBtnText,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),

              ),
            ),
          ],
        );
      },
    );
  }





}
