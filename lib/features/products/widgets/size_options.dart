import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/features/home/models/choice_option.dart';


/*
*  Date 28 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: SizeOptions
*/

class SizeOptions extends StatefulWidget {

  const SizeOptions({
    required this.choiceOptions,
    Key? key,
  }) : super(key: key);

  final ChoiceOptions choiceOptions;

  @override
  State<SizeOptions> createState() => _SizeOptionsState();
}

class _SizeOptionsState extends State<SizeOptions> {
  @override
  Widget build(BuildContext context) {

    return Wrap(
      direction: Axis.horizontal,
      children: [
        for (int i = 0;
        i <
            widget.choiceOptions.options!.length;
        i++)
          InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              for (int j = 0;
              j <
                  widget.choiceOptions.options!.length;
              j++) {
                if (j == i) {
                  widget.choiceOptions.options![j].isSelected = true;
                } else {
                  widget.choiceOptions.options![j].isSelected = false;
                }
              }

              setState(() {});
            },
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8.0),
              margin:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.choiceOptions.options![i].isSelected
                    ? AppColors.selectedOption.withOpacity(0.3)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppColors.borderColor,
                  width: 1,
                ),
              ),
              child: Text(
                widget.choiceOptions.options![i].name!,
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: AppColors.blackColor),
              ),
            ),
          ),
      ],
    );
  }
}
