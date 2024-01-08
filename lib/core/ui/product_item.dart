import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 29 - Oct-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ProductItem
*/

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
    this.isWishlistProduct = false,
    required this.addRemoveToWishlist,
  }) : super(key: key);

  final Products product;
  final bool isWishlistProduct;

  final VoidCallback addRemoveToWishlist;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 140,
              height: 170,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
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
                      '${APIs.imageBaseURL}${APIs.productThumbnailImages}${widget.product.thumbnail}',
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              right: 4,
              top: 0,
              child: !widget.isWishlistProduct
                  ? IconButton(
                      onPressed: widget.addRemoveToWishlist,
                      icon: Icon(
                        widget.product.wishlist != null &&
                                widget.product.wishlist!.productId ==
                                    widget.product.id
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 20,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () async {
                        await homeProvider
                            .removeFromWishlist(widget.product.id!);

                        if(mounted) {
                          await homeProvider.getWishlist(context, AppLocalizations.of(context).localeName);
                        }


                      },
                    ),
            ),

            /*
            Positioned(
              right: 4,
              top: 24,
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  width: 20,
                  height: 20,
                  Images.shareIcon,
                  color: AppColors.activeIcon,
                ),
              ),
            ),*/

            Positioned(
              left: 12,
              top: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.product.brand?.name! ?? '',
          style: const TextStyle(fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          widget.product.name!,
          style: const TextStyle(fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          '${widget.product.unitPrice} Sar',
          style: const TextStyle(fontSize: 20, color: AppColors.red),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
