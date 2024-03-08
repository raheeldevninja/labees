import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/enums/product_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 26 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: DescriptionSizesReviewsTabs
*/

class DescriptionSizesReviewsTabs extends StatefulWidget {
  const DescriptionSizesReviewsTabs({
    super.key,
    required this.productInfo,
    required this.descriptionCallback,
    required this.sizesCallback,
    required this.reviewsCallback,
  });

  final ProductInfo productInfo;
  final VoidCallback descriptionCallback;
  final VoidCallback sizesCallback;
  final VoidCallback reviewsCallback;

  @override
  State<DescriptionSizesReviewsTabs> createState() =>
      _DescriptionSizesReviewsTabsState();
}

class _DescriptionSizesReviewsTabsState
    extends State<DescriptionSizesReviewsTabs> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.maxFinite,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          color: AppColors.primaryColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              onTap: widget.descriptionCallback,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: widget.productInfo == ProductInfo.description
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  l10n.productDescriptionTab,
                  style: TextStyle(
                      fontSize: 10,
                      color: widget.productInfo == ProductInfo.description
                          ? Colors.white
                          : AppColors.primaryColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              onTap: widget.sizesCallback,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: widget.productInfo == ProductInfo.sizes
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  l10n.sizesTab,
                  style: TextStyle(
                      fontSize: 10,
                      color: widget.productInfo == ProductInfo.sizes
                          ? Colors.white
                          : AppColors.primaryColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              onTap: widget.reviewsCallback,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: widget.productInfo == ProductInfo.reviews
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  l10n.customerReviewsTab,
                  style: TextStyle(
                      fontSize: 10,
                      color: widget.productInfo == ProductInfo.reviews
                          ? Colors.white
                          : AppColors.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
