import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 23 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ImagesSlider
*/

class ImagesSlider extends StatelessWidget {
  ImagesSlider({
    super.key,
    required this.productImages,
  });

  final List<Widget> productImages;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        CarouselSlider(
          items: productImages,
          options: CarouselOptions(
              height: 300,
              enlargeCenterPage: false,
              aspectRatio: 16 / 9,
              viewportFraction: 1),
          carouselController: _controller,
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _controller.previousPage(
                      duration: const Duration(
                    milliseconds: 200,
                  ));
                },
                icon: Icon(
                  l10n.localeName == 'en'
                      ? Icons.keyboard_arrow_left_rounded
                      : Icons.keyboard_arrow_right_rounded,
                  size: 32,
                  color: AppColors.lightGrey,
                ),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _controller.nextPage(
                        duration: const Duration(
                      milliseconds: 200,
                    ));
                  },
                  icon: Icon(
                    l10n.localeName == 'en'
                        ? Icons.keyboard_arrow_right_rounded
                        : Icons.keyboard_arrow_left_rounded,
                    size: 32,
                    color: AppColors.lightGrey,
                  )),
            ],
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: 24,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(width: 1, color: Colors.grey)),
              child: const Text(
                'New Season',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
