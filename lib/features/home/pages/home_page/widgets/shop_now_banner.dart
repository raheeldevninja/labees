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
        InkWell(
          onTap: () {
            Utils.controller.jumpToTab(1);
          },
          child: Container(
            width: double.maxFinite,
            height: 150,
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
                fit: BoxFit.cover,
                imageUrl:
                    "https://labees.boedelipos.ch/storage/app/public/banner/2023-07-13-64afb66b05dd2.png",
                placeholder: (context, url) => const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
