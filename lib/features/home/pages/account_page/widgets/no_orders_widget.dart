import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/images/images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 20 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: NoOrdersWidget
*/


class NoOrdersWidget extends StatelessWidget {
  const NoOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.youHaveNotPlaceOrder,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: SvgPicture.asset(
            width: double.maxFinite,
            height: 170,
            Images.noAddress,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          width: double.maxFinite,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
            child: Text(
              l10n.shopNow,
            ),
          ),
        ),
      ],
    );
  }
}


