import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/orders_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/pages/account_page/account_tabs/view_model/order_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 29 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: OrderItem
*/

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.product, required this.orderData}) : super(key: key);

  final Details product;
  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //product image
            Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                '${APIs.imageBaseURL}${APIs.productThumbnailImages}${product.productDetails!.thumbnail}',
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productDetails!.name!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    product.productDetails!.brand!.name!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Libre Baskerville',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        '${l10n.quantityLabel} ${product.qty}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'Libre Baskerville',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        //order id
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.orderIdLabel,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
              product.orderId.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        //price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.priceLabel,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
              '${product.price} Sar',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
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
                l10n.addReviewBtnText,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
                : const SizedBox(),
          ],
        ),

      ],
    );
  }

  //rating and comment dialog
  void _showRatingAndCommentDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    double ratingValue = 0.0;
    final reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            l10n.ratingAndReviewLabel,
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
                itemBuilder: (context, _) => const Icon(
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
                  hintText: l10n.addReviewBtnText,
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
                await orderProvider.addReview(context,
                    orderData.id!, reviewController.text.trim(), ratingValue);

                if (orderProvider.addReviewResponse.status!) {
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
