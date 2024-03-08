import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:labees/core/app/app_colors.dart';
import 'dart:math' as math;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:provider/provider.dart';

/*
*  Date 20 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: WriteReview
*/

class WriteReview extends StatefulWidget {
  const WriteReview({Key? key}) : super(key: key);

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final _reviewController = TextEditingController();
  double ratingValue = 3.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews',
            style:
                const TextStyle(fontSize: 14, color: AppColors.primaryColor)),

        const SizedBox(
          height: 16,
        ),

        //review and comment listview

        ListView.builder(
          //itemCount: homeProvider.productDetails!.reviews!.length,
          itemCount: homeProvider.productDetails!.product!.reviewsList!.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final rating =
                homeProvider.productDetails!.product!.reviewsList![index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${rating.customer!.fName!} ${rating.customer!.lName!}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: rating.rating?.toDouble() ?? 0.0,
                      minRating: 1,
                      itemSize: 20,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          ratingValue = rating;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    Text(
                        '${rating.rating?.toDouble() ?? 0.0} ${l10n.ratingLabel}'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  rating.comment!,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),

        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    _reviewController.dispose();
  }
}
