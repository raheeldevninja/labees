import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/ui/most_wanted_banner_item.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/products/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 28 - September-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: MostWantedSection
*/

class MostWantedSection extends StatelessWidget {
  const MostWantedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final homeProvider = Provider.of<HomeProvider>(context);
    int length = homeProvider.dashboardData.mostWantedBanners?.length ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.mostWanted,
          style: const TextStyle(
            fontFamily: 'Libre Baskerville',
            fontSize: 18,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 194,
          child: ListView.builder(
            itemCount: length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsScreen(
                          id: homeProvider
                              .dashboardData.mostWantedBanners![index].id!,
                          title: homeProvider
                              .dashboardData.mostWantedBanners![index].title!),
                    ),
                  );
                },
                child: MostWantedBannerItem(
                  mostWantedBanners:
                      homeProvider.dashboardData.mostWantedBanners![index],
                  bgColor: Utils.bannerBgColors[index % length],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
