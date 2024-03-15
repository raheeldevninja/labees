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
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  mostWantedBanners.subTitle!,
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
                ),
                Text(
                  '${mostWantedBanners.title}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),



          Center(
            child: CachedNetworkImage(
              width: 120,
              height: 120,
              imageUrl:
              '${APIs.imageBaseURL}${APIs.bannerImages}${mostWantedBanners.photo!}',
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
