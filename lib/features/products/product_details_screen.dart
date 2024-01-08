import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/enums/product_info.dart';
import 'package:labees/core/models/brand.dart';
import 'package:labees/core/models/cart_choices.dart';
import 'package:labees/core/models/cart_product.dart';
import 'package:labees/core/models/category.dart';
import 'package:labees/core/models/product.dart';
import 'package:labees/core/models/product_color.dart';
import 'package:labees/core/models/product_size.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/my_bag/my_bag_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/products/widgets/description_sizes_reviews_tabs.dart';
import 'package:labees/features/products/widgets/images_slider.dart';
import 'package:labees/features/products/widgets/product_description.dart';
import 'package:labees/features/products/widgets/product_details_shimmer.dart';
import 'package:labees/features/products/widgets/product_sizes_widget.dart';
import 'package:labees/features/products/widgets/quantity_widget.dart';
import 'package:labees/features/products/widgets/shipping_info.dart';
import 'package:labees/features/products/widgets/similar_products.dart';
import 'package:labees/features/products/widgets/size_options.dart';
import 'package:labees/features/products/widgets/write_review.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
*  Date 22 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: ProductDetailsScreen
*/

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.slug}) : super(key: key);

  final String slug;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Product> products = [];
  List<Category> categories = [];
  List<Brand> brands = [];
  List<ProductSizes> sizes = [];

  List<ProductColor> colorsList = [];

  ProductInfo productInfo = ProductInfo.description;

  int qty = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('slug value received: ${widget.slug}');

      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.getProductDetails(context, AppLocalizations.of(context).localeName, widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final homeProvider = Provider.of<HomeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    Widget productDetailsWidget = const ProductDescription();

    int colorIndex = homeProvider.getColorIndex();
    int sizeIndex = homeProvider.getSizeIndex();

    if (homeProvider.getIsLoading || homeProvider.productDetails == null) {
      return const ColoredBox(
          color: AppColors.white, child: ProductDetailsShimmer());
    }

    if (homeProvider.productDetails!.images == null) {
      return const ColoredBox(color: AppColors.white);
    }

    final List<Widget> productImages = homeProvider.productDetails!.images!
        .map((item) => Stack(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey.withOpacity(0.2),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: CachedNetworkImage(
                      width: 250,
                      height: 250,
                      imageUrl:
                          '${APIs.imageBaseURL}${APIs.productImages}$item',
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: 24,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: const Text(
                        'New Season',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ))
        .toList();

    if (productInfo == ProductInfo.description) {
      productDetailsWidget = const ProductDescription();
    } else if (productInfo == ProductInfo.sizes) {
      productDetailsWidget = const ProductSizesWidget();
    } else if (productInfo == ProductInfo.reviews) {
      productDetailsWidget = const WriteReview();
    }

    return Scaffold(
      key: _scaffoldKey,
      body: homeProvider.productDetails == null
          ? Center(
              child: Text(l10n.noProductDetails),
            )
          : ListView(
              children: [
                ImagesSlider(productImages: productImages),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${homeProvider.productDetails!.name}',
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.primaryColor, fontWeight: FontWeight.bold)),

                      const SizedBox(
                        height: 16,
                      ),

                      Text(
                        '${homeProvider.productDetails!.shortDescription}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor,
                          height: 1.8
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: double.parse(
                                homeProvider.productDetails!.averageReview ??
                                    '0'),
                            minRating: 1,
                            itemSize: 30,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ignoreGestures: true,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppColors.starColor,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: 16),
                          Text(
                              '${homeProvider.productDetails!.averageReview} ${l10n.ratingLabel}'),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Text(
                        '${homeProvider.productDetails!.unitPrice} Sar',
                        style:
                            const TextStyle(fontSize: 20, color: AppColors.red),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        l10n.priceIncludingVAT,
                        style: const TextStyle(fontSize: 10),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      if (colorIndex != -1) ...[
                        Text(
                          l10n.colorLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            for (int i = 0;
                                i <
                                    homeProvider
                                        .productDetails!
                                        .choiceOptions![colorIndex]
                                        .options!
                                        .length;
                                i++)
                              InkWell(
                                borderRadius: BorderRadius.circular(30.0),
                                onTap: () {
                                  for (int j = 0;
                                      j <
                                          homeProvider
                                              .productDetails!
                                              .choiceOptions![colorIndex]
                                              .options!
                                              .length;
                                      j++) {
                                    if (j == i) {
                                      homeProvider
                                          .productDetails!
                                          .choiceOptions![colorIndex]
                                          .options![j]
                                          .isSelected = true;
                                    } else {
                                      homeProvider
                                          .productDetails!
                                          .choiceOptions![colorIndex]
                                          .options![j]
                                          .isSelected = false;
                                    }
                                  }




                                  setState(() {});
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(1.0),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: homeProvider
                                              .productDetails!
                                              .choiceOptions![colorIndex]
                                              .options![i]
                                              .isSelected
                                          ? AppColors.blackColor
                                          : Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: SvgPicture.network(
                                      '${APIs.imageBaseURL}${APIs.attributeValue}${homeProvider.productDetails!.choiceOptions![colorIndex].options![i].image!}',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        l10n.quantityLabel,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      ///quantity
                      QuantityWidget(
                        qty: qty,
                        qtyDecrement: () {
                          setState(() {
                            if (qty > 1) {
                              qty--;
                            }
                          });
                        },
                        qtyIncrement: () {
                          setState(() {
                            qty++;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      if (sizeIndex != -1) ...[
                        Text(
                          l10n.sizeLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        ///size options
                        SizeOptions(
                            choiceOptions: homeProvider
                                .productDetails!.choiceOptions![sizeIndex]),
                      ],

                      const SizedBox(
                        height: 20,
                      ),

                      ///shipping info
                      const ShippingInfo(),

                      const SizedBox(
                        height: 20,
                      ),

                      ///add to cart button and price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 160,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                List<CartChoices> choicesList = [];
                                String choiceStr = '';

                                for (int i = 0;
                                    i <
                                        homeProvider.productDetails!
                                            .choiceOptions!.length;
                                    i++) {
                                  for (int j = 0;
                                      j <
                                          homeProvider
                                              .productDetails!
                                              .choiceOptions![i]
                                              .options!
                                              .length;
                                      j++) {
                                    if (homeProvider
                                            .productDetails!
                                            .choiceOptions![i]
                                            .options![j]
                                            .isSelected ==
                                        true) {
                                      choicesList.add(CartChoices(
                                        name: homeProvider
                                            .productDetails!
                                            .choiceOptions![i]
                                            .options![j]
                                            .name!,
                                        attributeName: homeProvider
                                            .productDetails!
                                            .choiceOptions![i]
                                            .title!,
                                        attributeChoice: homeProvider
                                            .productDetails!
                                            .choiceOptions![i]
                                            .name!,
                                        id: homeProvider.productDetails!
                                            .choiceOptions![i].options![j].id!,
                                        attributeId: homeProvider
                                            .productDetails!
                                            .choiceOptions![i]
                                            .options![j]
                                            .attributeId!,
                                      ));

                                      choiceStr +=
                                          '${homeProvider.productDetails!.choiceOptions![i].options![j].attributeId!}-';
                                    }
                                  }
                                }

                                if (choiceStr.length > 1) {
                                  //remove last character
                                  choiceStr = choiceStr.substring(
                                      0, choiceStr.length - 1);
                                }

                                CartProduct cartProduct = CartProduct(
                                    id: homeProvider.productDetails!.id!,
                                    title: homeProvider.productDetails!.name!,
                                    brand: homeProvider
                                        .productDetails!.brand!.name!,
                                    image:
                                        homeProvider.productDetails!.thumbnail!,
                                    totalPrice: homeProvider
                                            .productDetails!.unitPrice! *
                                        qty,
                                    unitPrice:
                                        homeProvider.productDetails!.unitPrice!,
                                    quantity: qty,
                                    slug: homeProvider.productDetails!.slug!,
                                    currentSock: homeProvider
                                        .productDetails!.currentStock!,
                                    choiceString: choiceStr,
                                    choices: choicesList);

                                await SharedPref.addCartProduct(cartProduct);

                                await cartProvider.getCartProducts();

                                /*final cartProductsList = checkoutProvider.getPlaceOrderModel.cartProducts;
                                cartProductsList?.add(cartProduct);
                                checkoutProvider.getPlaceOrderModel.copyWith(cartProducts: cartProductsList);

                                print('place order model: ${checkoutProvider.getPlaceOrderModel.toJson()}');*/

                                if (mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyBagScreen(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                side: const BorderSide(
                                  width: 1.0,
                                  color: AppColors.red,
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                              ),
                              child: Text(
                                l10n.addToCartBtnText,
                                style: const TextStyle(color: AppColors.red),
                              ),
                            ),
                          ),
                          Text(
                            '${l10n.productCode}: ${homeProvider.productDetails!.code}',
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                color: AppColors.blackColor),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Text('${homeProvider.productDetails!.name}',
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.primaryColor, fontWeight: FontWeight.bold)),

                      const SizedBox(
                        height: 16,
                      ),

                      ///product info, sizes, and customer reviews tabs
                      DescriptionSizesReviewsTabs(
                        descriptionCallback: () {
                          setState(() {
                            productInfo = ProductInfo.description;
                          });
                        },
                        sizesCallback: () {
                          setState(() {
                            productInfo = ProductInfo.sizes;
                          });
                        },
                        reviewsCallback: () {
                          setState(() {
                            productInfo = ProductInfo.reviews;
                          });
                        },
                        productInfo: productInfo,
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      productDetailsWidget,

                      const SizedBox(
                        height: 16,
                      ),

                      if (homeProvider
                          .productDetails!.similarProducts!.isNotEmpty) ...[
                        Text(l10n.similarProductsLabel,
                            style: const TextStyle(
                                fontSize: 18, color: AppColors.primaryColor, fontWeight: FontWeight.bold)),

                        const SizedBox(
                          height: 8,
                        ),

                        ///similar products
                        SimilarProducts(slug: widget.slug,),
                      ],
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

