import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labees/core/app/app_colors.dart';
import 'package:labees/core/enums/product_info.dart';
import 'package:labees/core/models/brand.dart';
import 'package:labees/core/models/cart_choices.dart';
import 'package:labees/core/models/cart_product.dart';
import 'package:labees/core/models/category.dart';
import 'package:labees/core/models/product_color.dart';
import 'package:labees/core/models/product_size.dart';
import 'package:labees/core/util/apis.dart';
import 'package:labees/core/util/shared_pref.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/home/view_model/home_provider.dart';
import 'package:labees/features/my_bag/my_bag_screen.dart';
import 'package:labees/features/my_bag/view_model/cart_provider.dart';
import 'package:labees/features/products/widgets/description_sizes_reviews_tabs.dart';
import 'package:labees/features/products/widgets/full_screen_product_images_screen.dart';
import 'package:labees/features/products/widgets/images_slider.dart';
import 'package:labees/features/products/widgets/product_care_widget.dart';
import 'package:labees/features/products/widgets/product_description.dart';
import 'package:labees/features/products/widgets/product_details_shimmer.dart';
import 'package:labees/features/products/widgets/product_sizes_widget.dart';
import 'package:labees/features/products/widgets/quantity_widget.dart';
import 'package:labees/features/products/widgets/shipping_info.dart';
import 'package:labees/features/products/widgets/similar_products.dart';
import 'package:labees/features/products/widgets/size_options.dart';
import 'package:labees/features/products/widgets/write_review.dart';
import 'package:labees/features/seller/seller_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/models/variant_products.dart';

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

  List<Category> categories = [];
  List<Brand> brands = [];
  List<ProductSizes> sizes = [];

  List<ProductColor> colorsList = [];

  ProductInfo productInfo = ProductInfo.description;

  int qty = 1;

  String attributeSelection = '';
  int colorIndex = -1;
  int sizeIndex = -1;

  List<String> selectedChoiceOptions = [];

  var product;

  List productMainImages = [];
  VariantProducts? variantProduct;
  var variantProductImages;
  List<String> productImagesList = [];

  Map<String, List> selectedAttributes = {};

  late TapGestureRecognizer tapGestureRecognizer;

  String shortDescription = '';
  String price = '';

  List<Widget> productImages = [];

  bool isProductInWishlist = false;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('slug value received: ${widget.slug}');

      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.getProductDetails(
        context,
        AppLocalizations.of(context)!.localeName,
        widget.slug,
        //'tommy-shirt-red-RwfQQB',
      );

      product = homeProvider.productDetails!.product;

      productMainImages = product?.images!;

      variantProduct = product?.variantProducts!.isNotEmpty
          ? product!.variantProducts!.first
          : null;

      variantProductImages = variantProduct?.images;

      productImagesList = product?.variantProducts?.isNotEmpty
          ? variantProductImages
          : productMainImages;

      print('productImagesList ${productImagesList}');

      ///populate attributes

      if (product!.choiceOptions != null) {
        for (int i = 0; i < product!.choiceOptions!.length; i++) {
          selectedAttributes[product!.choiceOptions![i].title!] = [];
        }
      }

      shortDescription = product.shortDescription ?? '';

      if(product.taxType == 'percent') {

        //print('highest ${product.priceRange.highestPrice + (product.priceRange.highestPrice * (product.tax / 100))}');

        print('in if');


        if(product.priceRange != null) {
          price = 'SAR ${product.priceRange.lowestPrice + (product.priceRange.lowestPrice * product.tax / 100)} - SAR ${product.priceRange.highestPrice + (product.priceRange.highestPrice * (product.tax / 100))}';
        }
        else {
          price = 'SAR ${product.unitPrice + (product.unitPrice * product.tax / 100)}';
        }


      }
      else {
        print('in else');


        if(product.priceRange != null) {
          price = 'SAR ${product.priceRange.lowestPrice + product.tax} - SAR ${product.priceRange.highestPrice + product.tax}';
        }
        else {
          price = 'SAR ${product.unitPrice + product.tax}';
        }

      }

      isProductInWishlist = await SharedPref.isProductInWishlist(product.id!.toString());


    });
  }

  _isProductInWishlist() async {
    isProductInWishlist = await SharedPref.isProductInWishlist(product.id!.toString());
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final homeProvider = Provider.of<HomeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final isVariantProduct = product?.variantProducts.isNotEmpty ?? false;



    //homeProvider.productDetails!.product!.variantProducts!.isNotEmpty ? homeProvider.productDetails!.product!.variantProducts!.first :
    product = homeProvider.productDetails?.product;

    //variantProduct = isVariantProduct ? product.variantProducts.first : null;

    Widget productDetailsWidget = const ProductDescription();

    /*colorIndex = homeProvider.getColorIndex();
    sizeIndex = homeProvider.getSizeIndex();*/

    if (homeProvider.getIsLoading || homeProvider.productDetails == null) {
      return const ColoredBox(
          color: AppColors.white, child: ProductDetailsShimmer());
    }

    if (product == null || product.images == null) {
      return const ColoredBox(color: AppColors.white);
    }

    _isProductInWishlist();


    productImages = productImagesList
        .map((item) => Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenProductImagesScreen(
                          images: isVariantProduct
                              ? variantProduct!.images
                              : product.images!,
                        ),
                      ),
                    );
                  },
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
              ],
            ))
        .toList();

    //print('productImages length in build: ${productImages.length}');

    if (productInfo == ProductInfo.description) {
      productDetailsWidget = const ProductDescription();
    } else if (productInfo == ProductInfo.sizes) {
      productDetailsWidget = const ProductSizesWidget();
    } else if (productInfo == ProductInfo.reviews) {
      productDetailsWidget = const ProductCareWidget();
    }

    final attributes = product.attributes;
    final choiceOptions = product.choiceOptions;

    return Scaffold(
      key: _scaffoldKey,
      body: homeProvider.productDetails == null
          ? Center(
              child: Text(l10n.noProductDetails),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await homeProvider.getProductDetails(
                  context,
                  AppLocalizations.of(context)!.localeName,
                  widget.slug,
                );
              },
              child: ListView(
                children: [
                  ImagesSlider(productImages: productImages),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${isVariantProduct ? variantProduct!.name : product.name}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),

                            IconButton(
                              onPressed: () async {


                                bool result = await SharedPref.isProductInWishlist(product.id.toString());

                                if (result) {

                                  print('remove from wishlist');
                                  await SharedPref.removeWishlistProduct(product.id.toString());


                                }
                                else {

                                  Products wishListProduct = Products(
                                    id: product.id,
                                    name: product.name,
                                    thumbnail: product.thumbnail,
                                    unitPrice: product.unitPrice.toDouble(),
                                    tax: product.tax,
                                    taxType: product.taxType,
                                    brand: product.brand,
                                    slug: product.slug,
                                    currentStock: product.currentStock,
                                    images: product.images,
                                    shortDescription: product.shortDescription,
                                  );

                                  print('add to wishlist');
                                  await SharedPref.addWishlistProduct(wishListProduct);

                                }


                              },
                              icon: Icon(
                                isProductInWishlist
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ],
                        ),


                        Text('${product.brand!.name}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.blackColor,
                                    height: 1.8),
                              ),


                        if(shortDescription.isNotEmpty) ...[
                          const SizedBox(
                            height: 16,
                          ),

                          Text(shortDescription,
                            style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor,
                                height: 1.8),
                          ),


                        ],

                        const SizedBox(
                          height: 16,
                        ),


                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating:
                                  double.parse(product.averageReview ?? '0.0'),
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
                                '${product.averageReview} ${l10n.ratingLabel}'),
                          ],
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        Text(
                          //'${isVariantProduct ? variantProduct!.unitPrice : product.unitPrice} Sar',
                          price,
                          style: const TextStyle(
                              fontSize: 20, color: AppColors.red),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          l10n.priceIncludingVAT,
                          style: const TextStyle(fontSize: 12),
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        ///new colors and sizes section
                        for (int attributeIndex = 0;
                            attributeIndex < attributes!.length;
                            attributeIndex++) ...[
                          for (int i = 0; i < choiceOptions!.length; i++) ...[
                            if (attributes[attributeIndex].toString() ==
                                choiceOptions[i].attributeId) ...[
                              Text(
                                choiceOptions[i].title!,
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
                                  for (int choiceOptionIndex = 0;
                                      choiceOptionIndex <
                                          choiceOptions[i].options!.length;
                                      choiceOptionIndex++) ...[
                                    InkWell(
                                      onTap: () {

                                        if (choiceOptions[i].title == 'Color') {
                                          for (int j = 0; j < choiceOptions[i].options!.length; j++) {

                                            if (j == choiceOptionIndex) {
                                              choiceOptions[i]
                                                  .options![j]
                                                  .isSelected = true;
                                            }
                                            else {
                                              choiceOptions[i]
                                                  .options![j]
                                                  .isSelected = false;
                                            }
                                          }

                                          homeProvider.setSelectedColor(
                                              choiceOptions[i]
                                                  .options![choiceOptionIndex]
                                                  .name!);

                                          print(
                                              'color: ${homeProvider.getSelectedColor}');

                                        } else if (choiceOptions[i].title == 'Size') {

                                          for (int j = 0;
                                              j <
                                                  choiceOptions[i]
                                                      .options!
                                                      .length;
                                              j++) {
                                            for (int j = 0;
                                                j <
                                                    choiceOptions[i]
                                                        .options!
                                                        .length;
                                                j++) {
                                              if (j == choiceOptionIndex) {
                                                choiceOptions[i]
                                                    .options![j]
                                                    .isSelected = true;
                                              } else {
                                                choiceOptions[i]
                                                    .options![j]
                                                    .isSelected = false;
                                              }
                                            }
                                          }

                                          homeProvider.setSelectedSize(
                                              choiceOptions[i]
                                                  .options![choiceOptionIndex]
                                                  .name!);
                                        }

                                        ///update variant product

                                        for (int j = 0; j < choiceOptions[i].options!.length; j++) {

                                          if (choiceOptions[i].options![j].isSelected) {

                                            //add selected choice option id
                                            selectedAttributes[choiceOptions[i].title!] = [choiceOptions[i].options![j].id];

                                          }
                                        }

                                        //join selectedAttributes values
                                        String selectedChoicesIds =
                                            selectedAttributes.values
                                                .expand((element) => element)
                                                .toList()
                                                .join(',');

                                        print(
                                            'selected choice options: $selectedChoicesIds');

                                        //update variant product
                                        product.variantProducts!
                                            .forEach((element) {
                                          print(
                                              'element: ${element.childAttributeValueIds}');

                                          //if(element.childAttributeValueIds == selectedChoiceOptions.join(',')) {
                                          if (element.childAttributeValueIds ==
                                              selectedChoicesIds) {
                                            print(
                                                'variant product found: ${element.name}');

                                            setState(() {

                                              variantProduct = element;
                                              variantProductImages =
                                                  variantProduct!.images;

                                              productImagesList =
                                                  isVariantProduct
                                                      ? variantProductImages
                                                      : productMainImages;

                                            });

                                            print(
                                                'current stock: ${variantProduct?.currentStock}');

                                            if (variantProduct?.currentStock ==
                                                0) {

                                              //Utils.toast('Out of stock');
                                              Utils.showCustomSnackBar(context, 'Out of stock', ContentType.warning);

                                            }
                                          }
                                        });

                                        //check stock
                                        if (variantProduct != null &&
                                            product
                                                .variantProducts!.isNotEmpty) {
                                          int variationQty = 0;

                                          for (int varIndex = 0;
                                              varIndex <
                                                  product
                                                      .variantProducts.length;
                                              varIndex++) {
                                            if (product
                                                    .variantProducts[varIndex]
                                                    .childAttributeValueIds ==
                                                selectedChoicesIds) {
                                              variationQty = product
                                                  .variantProducts[varIndex]
                                                  .currentStock!;
                                            }
                                          }

                                          print('qty : $variationQty');

                                          print('sel ${selectedAttributes.length}');

                                          selectedAttributes.forEach((key, value) {
                                            print('key: $key, value: $value');
                                          });

                                          if (variationQty == 0 && selectedChoicesIds.length > 2) {
                                            //Utils.toast('Out of stock');
                                            Utils.showCustomSnackBar(context, 'Out of stock', ContentType.warning);
                                          }
                                          /*else if (variationQty < qty) {
                                            Utils.showCustomSnackBar(context,
                                                'Only $variationQty left in stock');
                                          }*/



                                          if(isVariantProduct) {
                                            shortDescription = variantProduct!.shortDescription ?? '';

                                            if(variantProduct!.taxType == 'percent') {
                                              price = 'SAR ${variantProduct!.unitPrice! + (variantProduct!.unitPrice! * variantProduct!.tax! / 100)}';
                                            }
                                            else {
                                              price = 'SAR ${variantProduct!.unitPrice! + variantProduct!.tax!}';
                                            }

                                          }
                                          else {
                                            shortDescription = product.shortDescription;

                                            if(product.taxType == 'percent') {
                                              price = 'SAR ${product.unitPrice + (product.unitPrice * product.tax / 100)}';
                                            }
                                            else {
                                              price = 'SAR ${product.unitPrice + product.tax}';
                                            }

                                          }



                                        }

                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        alignment: Alignment.center,
                                        padding:
                                            choiceOptions[i].title == 'Color'
                                                ? const EdgeInsets.all(1.0)
                                                : const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                          color: choiceOptions[i]
                                                  .options![choiceOptionIndex]
                                                  .isSelected
                                              ? AppColors.selectedOption
                                                  .withOpacity(0.3)
                                              : Colors.white,
                                          shape:
                                              choiceOptions[i].title == 'Color'
                                                  ? BoxShape.circle
                                                  : BoxShape.rectangle,
                                          border: Border.all(
                                            color: choiceOptions[i]
                                                    .options![choiceOptionIndex]
                                                    .isSelected
                                                ? AppColors.blackColor
                                                : Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              choiceOptions[i].title == 'Color'
                                                  ? null
                                                  : BorderRadius.circular(8.0),
                                        ),
                                        child: choiceOptions[i].title == 'Color'
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60.0),
                                                child: SvgPicture.network(
                                                  '${APIs.imageBaseURL}${APIs.attributeValue}${choiceOptions[i].options![choiceOptionIndex].image ?? ''}',
                                                  width: 40,
                                                  height: 40,
                                                ),
                                              )
                                            : Text(
                                                choiceOptions[i]
                                                    .options![choiceOptionIndex]
                                                    .name!,
                                                style: const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                    color:
                                                        AppColors.blackColor),
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
                        ],

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
                              choiceOptions: product.choiceOptions![sizeIndex]),
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
                                  int variationQty = 0;

                                  for (int i = 0;
                                      i < product.choiceOptions!.length;
                                      i++) {
                                    for (int j = 0;
                                        j <
                                            product.choiceOptions![i].options!
                                                .length;
                                        j++) {
                                      if (product.choiceOptions![i].options![j]
                                              .isSelected ==
                                          true) {
                                        choicesList.add(CartChoices(
                                          name: product.choiceOptions![i]
                                              .options![j].name!,
                                          attributeName:
                                              product.choiceOptions![i].title!,
                                          attributeChoice:
                                              product.choiceOptions![i].name!,
                                          id: product.choiceOptions![i]
                                              .options![j].id!,
                                          attributeId: product.choiceOptions![i]
                                              .options![j].attributeId!,
                                        ));

                                        //choiceStr += '${product.choiceOptions![i].options![j].id!}-';
                                      }
                                    }
                                  }

                                  choiceStr = selectedAttributes.values
                                      .expand((element) => element)
                                      .toList()
                                      .join('-');

                                  String selectedChoicesIds = selectedAttributes
                                      .values
                                      .expand((element) => element)
                                      .toList()
                                      .join(',');

                                  if (isVariantProduct && choiceStr == '') {
                                    Utils.showCustomSnackBar(context, 'Please select attributes', ContentType.warning);
                                    return;
                                  }

                                  /*if (choiceStr.length > 1) {
                                    choiceStr = choiceStr.substring(
                                        0, choiceStr.length - 1);
                                  }*/

                                  /*if (selectedChoicesIds.length > 1) {
                                    selectedChoicesIds = selectedChoicesIds.substring(
                                        0, selectedChoicesIds.length - 1);
                                  }*/

                                  print('choice str: $selectedChoicesIds');

                                  if (product.variantProducts != null &&
                                      product.variantProducts!.isNotEmpty) {
                                    for (int varIndex = 0;
                                        varIndex <
                                            product.variantProducts.length;
                                        varIndex++) {
                                      if (product.variantProducts[varIndex]
                                              .childAttributeValueIds ==
                                          selectedChoicesIds) {
                                        variationQty = product
                                            .variantProducts[varIndex]
                                            .currentStock!;
                                      }
                                    }

                                    print('add to cart qty : $variationQty');

                                    if (variationQty == 0) {
                                      //Utils.toast('Out of stock');
                                      Utils.showCustomSnackBar(context, 'Out of stock', ContentType.warning);
                                      return;
                                    } else if (variationQty < qty) {
                                      Utils.showCustomSnackBar(context,
                                          'Only $variationQty left in stock', ContentType.warning);

                                      setState(() {
                                        qty = variationQty;
                                      });

                                      return;
                                    }
                                  }

                                  print('new choice str: $choiceStr');


                                  var unitPrice = isVariantProduct
                                      ? variantProduct!.unitPrice
                                      : product.unitPrice;

                                  if(product.taxType == 'percent') {
                                    unitPrice = unitPrice! + (unitPrice * product.tax / 100);
                                  }
                                  else {
                                    unitPrice = unitPrice! + product.tax;
                                  }


                                  CartProduct cartProduct = CartProduct(
                                    id: isVariantProduct ? variantProduct!.id : product.id!,
                                    title: isVariantProduct ? variantProduct!.name : product.name!,
                                    brand: product.brand!.name!,
                                    image: isVariantProduct ? variantProduct!.thumbnail : product.thumbnail!,
                                    totalPrice: unitPrice.toInt() * qty,
                                    unitPrice: unitPrice.toInt(),
                                    quantity: qty,
                                    slug: isVariantProduct ? variantProduct!.slug : product.slug!,
                                    currentSock: isVariantProduct
                                        ? variantProduct!.currentStock
                                        : product.currentStock!,
                                    choiceString: choiceStr,
                                    choices: choicesList,
                                  );

                                  await SharedPref.addCartProduct(cartProduct);

                                  await cartProvider.getCartProducts();

                                  if (mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MyBagScreen(),
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
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${l10n.productCode}: ${isVariantProduct ? variantProduct!.code : product.code}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.blackColor),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Sold by: ',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.blackColor),
                                      children: [

                                        TextSpan(
                                          text: '${homeProvider.productDetails!.product!.seller!.shop!.name}',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.red,
                                            decoration: TextDecoration.underline,
                                          ),
                                         recognizer: TapGestureRecognizer()..onTap = () {

                                            //navigate to seller profile
                                           Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SellerProfileScreen(
                                                  sellerId: homeProvider.productDetails!.product!.seller!.id!,
                                                ),
                                              ),
                                           );


                                         },
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Text(
                          '${product.name}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),

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

                        //reviews
                        const WriteReview(),

                        const SizedBox(
                          height: 16,
                        ),

                        if (product.similarProducts != null &&
                            product.similarProducts!.isNotEmpty) ...[
                          Text(l10n.similarProductsLabel,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),

                          const SizedBox(
                            height: 8,
                          ),

                          ///similar products
                          SimilarProducts(
                            slug: widget.slug,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
