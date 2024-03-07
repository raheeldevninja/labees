import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/*
*  Date 25 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: QuantityWidget
*/

class QuantityWidget extends StatefulWidget {
  const QuantityWidget({
    required this.qty,
    required this.qtyDecrement,
    required this.qtyIncrement,
    super.key,
  });

  final int qty;
  final VoidCallback qtyDecrement;
  final VoidCallback qtyIncrement;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: 120,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 1, color: AppColors.borderColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: widget.qtyDecrement,
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(l10n.localeName == 'en'
                  ? Icons.keyboard_arrow_left_rounded
                  : Icons.keyboard_arrow_right_rounded, size: 16),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.qty.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: widget.qtyIncrement,
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(l10n.localeName == 'en'
                  ? Icons.keyboard_arrow_right_rounded
                  : Icons.keyboard_arrow_left_rounded, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
