import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/shared_pref.dart';
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
    this.isSearchProduct = false,
    required this.addRemoveToWishlist,
  }) : super(key: key);

  final Products product;
  final bool isWishlistProduct;
  final bool isSearchProduct;

  final VoidCallback addRemoveToWishlist;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  bool isProductInWishlist = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('isProduct in wishlist : $isProductInWishlist');
      isProductInWishlist = await SharedPref.isProductInWishlist(widget.product.id!.toString());

    });


  }

  _isProductInWishlist() async {
    isProductInWishlist = await SharedPref.isProductInWishlist(widget.product.id!.toString());
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final homeProvider = Provider.of<HomeProvider>(context);

    final tagName = widget.product.tagDetails!.isNotEmpty
        ? widget.product.tagDetails?.first.name!
        : '';

    _isProductInWishlist();

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
            widget.isSearchProduct
                ? const SizedBox()
                : Positioned(
                    right: 4,
                    top: 0,
                    child: !widget.isWishlistProduct
                        ? IconButton(
                            onPressed: widget.addRemoveToWishlist,
                            icon: Icon(
                              // widget.product.wishlist != null &&
                              //         widget.product.wishlist!.productId ==
                              //             widget.product.id
                              //     ? Icons.favorite
                              //     : Icons.favorite_border,

                              isProductInWishlist ? Icons.favorite
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
                              /*await homeProvider
                                  .removeFromWishlist(widget.product.id!);

                              if (mounted) {
                                await homeProvider.getWishlist(context,
                                    AppLocalizations.of(context)!.localeName);
                              }

                              print(
                                  'called dashbaord data: ${homeProvider.getMainCategoryId}');

                              await homeProvider.getDashboardData(
                                context,
                                true,
                                l10n.localeName,
                                homeProvider.getMainCategoryId,
                                'all',
                              );*/

                              //await SharedPref.removeWishlistProduct(widget.product.id!.toString());



                              widget.addRemoveToWishlist();

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
              child: tagName!.isEmpty
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Text(
                        tagName ?? '',
                        style: const TextStyle(fontSize: 10),
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

        //choice_options

          for (int i = 0; i < widget.product.choiceOptions!.length; i++) ...[

              Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: [
                  for (int choiceOptionIndex = 0; choiceOptionIndex < widget.product.choiceOptions![i].options!.length; choiceOptionIndex++) ...[
                    Container(
                      width: widget.product.choiceOptions![i].title == 'Color' ? 16 : 24,
                      height: widget.product.choiceOptions![i].title == 'Color' ? 16 : 24,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: widget.product.choiceOptions![i]
                            .options![choiceOptionIndex]
                            .isSelected
                            ? AppColors.selectedOption
                            .withOpacity(0.3)
                            : Colors.white,
                        shape:
                        widget.product.choiceOptions![i].title == 'Color'
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                        border: Border.all(
                          color: widget.product.choiceOptions![i].title == 'Color'
                              ? Colors.transparent
                              : AppColors.blackColor,
                          width: 1,
                        ),
                        borderRadius:
                        widget.product.choiceOptions![i].title == 'Color'
                            ? null
                            : BorderRadius.circular(4.0),
                      ),
                      child: widget.product.choiceOptions![i].title == 'Color'
                          ? ClipRRect(
                        borderRadius:
                        BorderRadius.circular(30.0),
                        child: SvgPicture.network(
                          '${APIs.imageBaseURL}${APIs.attributeValue}${widget.product.choiceOptions![i].options![choiceOptionIndex].image ?? ''}',
                          width: 16,
                          height: 16,
                        ),
                      )
                          : Text(
                        widget.product.choiceOptions![i].options![choiceOptionIndex].name!,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color:
                          AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(
                height: 10,
              ),

          ],


      ],
    );
  }
}
