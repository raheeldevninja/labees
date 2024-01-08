import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/models/orders_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/core/util/apis.dart';

/*
*  Date 29 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: OrderItem
*/


class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.product}) : super(key: key);

  final Details product;


  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context);

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
                        'Qty ${product.qty}',
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

        const Divider(
          height: 32,
        ),

      ],
    );
  }
}
