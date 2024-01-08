import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/util/utils.dart';


/*
*  Date 16 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ShopNowBanner
*/

class ShopNowBanner extends StatelessWidget {
  const ShopNowBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl:
              "https://labees.mydomain101.net/storage/app/public/category/2023-08-29-64eda114079b4.jpg",
              placeholder: (context, url) =>
              const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: InkWell(
            onTap: () {
              Utils.controller.jumpToTab(1);
            },
            child: Container(
              width: 140,
              height: 36,
              //padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: const BorderRadius.all(
                  Radius.circular(60),
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Shop Now',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(Icons.arrow_right_alt,
                      color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
