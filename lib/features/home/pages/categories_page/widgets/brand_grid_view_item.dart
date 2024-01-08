import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/brand.dart';

/*
*  Date 20 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: BrandGridViewItem
*/

class BrandGridViewItem extends StatelessWidget {

  const BrandGridViewItem({
    super.key,
    required this.brand,
  });

  final Brand brand;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.lightGrey.withOpacity(0.2),
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: SvgPicture.network(
          '${APIs.imageBaseURL}${APIs.brandImages}${brand.image}'),
    );
  }
}