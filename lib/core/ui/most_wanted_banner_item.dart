import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/dashboard_data.dart';

/*
*  Date 29 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: MostWantedBannerItem
*/

class MostWantedBannerItem extends StatelessWidget {
  const MostWantedBannerItem({
    Key? key,
    required this.mostWantedBanners,
    required this.bgColor,
  }) : super(key: key);

  final MostWantedBanners mostWantedBanners;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            bgColor.withOpacity(0.5),
            bgColor,
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CachedNetworkImage(
              width: 90,
              height: 90,
              imageUrl:
                  '${APIs.imageBaseURL}${APIs.bannerImages}${mostWantedBanners.photo!}',
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            mostWantedBanners.subTitle!,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            '${mostWantedBanners.title}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
