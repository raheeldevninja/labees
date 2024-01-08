import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';


/*
*  Date 1 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: SummarySheet
*/

class Widgets {

  static Widget labels(String label, {bool isRequired = true}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
          ),
        ),
        isRequired ? const Text(
          '*',
          style: TextStyle(color: AppColors.requiredColor),
        ) : const SizedBox(),
      ],
    );
  }

}