// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:labees/core/app/app_colors.dart';
// import 'package:labees/core/enums/product_info.dart';
// import 'package:labees/core/models/brand.dart';
// import 'package:labees/core/models/cart_choices.dart';
// import 'package:labees/core/models/cart_product.dart';
// import 'package:labees/core/models/category.dart';
// import 'package:labees/core/models/product.dart';
// import 'package:labees/core/models/product_color.dart';
// import 'package:labees/core/models/product_size.dart';
// import 'package:labees/core/util/apis.dart';
// import 'package:labees/core/util/shared_pref.dart';
// import 'package:labees/core/util/utils.dart';
// import 'package:labees/features/home/view_model/home_provider.dart';
// import 'package:labees/features/my_bag/my_bag_screen.dart';
// import 'package:labees/features/my_bag/view_model/cart_provider.dart';
// import 'package:labees/features/products/widgets/description_sizes_reviews_tabs.dart';
// import 'package:labees/features/products/widgets/full_screen_product_images_screen.dart';
// import 'package:labees/features/products/widgets/images_slider.dart';
// import 'package:labees/features/products/widgets/product_description.dart';
// import 'package:labees/features/products/widgets/product_details_shimmer.dart';
// import 'package:labees/features/products/widgets/product_sizes_widget.dart';
// import 'package:labees/features/products/widgets/quantity_widget.dart';
// import 'package:labees/features/products/widgets/shipping_info.dart';
// import 'package:labees/features/products/widgets/similar_products.dart';
// import 'package:labees/features/products/widgets/size_options.dart';
// import 'package:labees/features/products/widgets/write_review.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
//
// class ProductDetailsScreen extends StatefulWidget {
//   const ProductDetailsScreen({Key? key, required this.slug}) : super(key: key);
//
//   final String slug;
//
//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   List<Product> products = [];
//   List<Category> categories = [];
//   List<Brand> brands = [];
//   List<ProductSizes> sizes = [];
//
//   List<ProductColor> colorsList = [];
//
//   ProductInfo productInfo = ProductInfo.description;
//
//   int qty = 1;
//
//   String attributeSelection = '';
//   int colorIndex = -1;
//   int sizeIndex = -1;
//
//   List<String> selectedChoiceOptions = [];
//
//   var nonVariantProductImages;
//   var variantProduct;
//   var variantProductImages;
//   List<Widget> productImagesList = [];
//
//   Map<String, List> selectedAttributes = {};
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       print('slug value received: ${widget.slug}');
//
//       final homeProvider = Provider.of<HomeProvider>(context, listen: false);
//       await homeProvider.getProductDetails(
//           context, AppLocalizations.of(context)!.localeName, widget.slug);
//
//       nonVariantProductImages = homeProvider.productDetails!.product!.images!;
//       variantProductImages = variantProduct!.images;
//
//       productImagesList =
//           homeProvider.productDetails!.product!.variantProducts!.isNotEmpty
//               ? variantProductImages
//               : nonVariantProductImages;
//
//       variantProduct =
//           homeProvider.productDetails!.product!.variantProducts!.isNotEmpty
//               ? homeProvider.productDetails!.product!.variantProducts!.first
//               : null;
//
//       ///populate attributes
//
//       if (homeProvider.productDetails!.product!.choiceOptions != null) {
//         for (int i = 0;
//             i < homeProvider.productDetails!.product!.choiceOptions!.length;
//             i++) {
//           selectedAttributes[homeProvider
//               .productDetails!.product!.choiceOptions![i].title!] = [];
//         }
//       }
//
//       //set selected choices
//       /*if (homeProvider.productDetails!.product!.choiceOptions != null && homeProvider.productDetails!.product!.choiceOptions!.isNotEmpty) {
//         for (int i = 0;
//             i < homeProvider.productDetails!.product!.choiceOptions!.length;
//             i++) {
//           attributeSelection =
//               homeProvider.productDetails!.product!.choiceOptions![i].options![0].name!;
//         }
//
//         attributeSelection = homeProvider.productDetails!.product!.choiceOptions![0].name!;
//       }
//
//       if(homeProvider.productDetails!.product!.choiceOptions != null) {
//
//         colorIndex = homeProvider.getColorIndex();
//         sizeIndex = homeProvider.getSizeIndex();
//
//
//         if(colorIndex != -1 ) {
//           homeProvider
//               .productDetails!.product!
//               .choiceOptions![colorIndex]
//               .options![0]
//               .isSelected = true;
//         }
//
//         if(sizeIndex != -1 ) {
//           homeProvider
//               .productDetails!.product!
//               .choiceOptions![sizeIndex]
//               .options![0]
//               .isSelected = true;
//         }
//
//       }*/
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//
//     final homeProvider = Provider.of<HomeProvider>(context);
//     final cartProvider = Provider.of<CartProvider>(context);
//
//     Widget productDetailsWidget = const ProductDescription();
//
//     /*colorIndex = homeProvider.getColorIndex();
//     sizeIndex = homeProvider.getSizeIndex();*/
//
//     print('color index: $colorIndex');
//     print('size index: $sizeIndex');
//
//     if (homeProvider.getIsLoading || homeProvider.productDetails == null) {
//       return const ColoredBox(
//           color: AppColors.white, child: ProductDetailsShimmer());
//     }
//
//     if (homeProvider.productDetails!.product == null ||
//         homeProvider.productDetails!.product!.images == null) {
//       return const ColoredBox(color: AppColors.white);
//     }
//
//     // final List<Widget> productImages = homeProvider
//     //     .productDetails!.product!.images!
//     final List<Widget> productImages = productImagesList
//         .map((item) => Stack(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FullScreenProductImagesScreen(
//                           images: homeProvider.productDetails!.product!.images!,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGrey.withOpacity(0.2),
//                     ),
//                     alignment: Alignment.bottomCenter,
//                     child: CachedNetworkImage(
//                       width: 250,
//                       height: 250,
//                       imageUrl:
//                           '${APIs.imageBaseURL}${APIs.productImages}$item',
//                       placeholder: (context, url) =>
//                           const CupertinoActivityIndicator(),
//                       errorWidget: (context, url, error) =>
//                           const Icon(Icons.error),
//                     ),
//                   ),
//                 ),
//               ],
//             ))
//         .toList();
//
//     if (productInfo == ProductInfo.description) {
//       productDetailsWidget = const ProductDescription();
//     } else if (productInfo == ProductInfo.sizes) {
//       productDetailsWidget = const ProductSizesWidget();
//     } else if (productInfo == ProductInfo.reviews) {
//       productDetailsWidget = const WriteReview();
//     }
//
//     print('product name: ${homeProvider.productDetails!.product!.name}');
//
//     final attributes = homeProvider.productDetails!.product!.attributes;
//     final choiceOptions = homeProvider.productDetails!.product!.choiceOptions;
//
//     return Scaffold(
//       key: _scaffoldKey,
//       body: homeProvider.productDetails == null
//           ? Center(
//               child: Text(l10n.noProductDetails),
//             )
//           : ListView(
//               children: [
//                 ImagesSlider(productImages: productImages),
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('${homeProvider.productDetails!.product!.name}',
//                           style: const TextStyle(
//                               fontSize: 18,
//                               color: AppColors.primaryColor,
//                               fontWeight: FontWeight.bold)),
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       homeProvider.productDetails!.product!.shortDescription !=
//                               null
//                           ? Text(
//                               '${homeProvider.productDetails!.product!.shortDescription}',
//                               style: const TextStyle(
//                                   fontSize: 12,
//                                   color: AppColors.blackColor,
//                                   height: 1.8),
//                             )
//                           : const SizedBox(),
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       Row(
//                         children: [
//                           RatingBar.builder(
//                             initialRating: double.parse(homeProvider
//                                     .productDetails!.product!.averageReview ??
//                                 '0.0'),
//                             minRating: 1,
//                             itemSize: 30,
//                             direction: Axis.horizontal,
//                             allowHalfRating: true,
//                             itemCount: 5,
//                             ignoreGestures: true,
//                             itemPadding:
//                                 const EdgeInsets.symmetric(horizontal: 0.0),
//                             itemBuilder: (context, _) => const Icon(
//                               Icons.star,
//                               color: AppColors.starColor,
//                             ),
//                             onRatingUpdate: (rating) {},
//                           ),
//                           const SizedBox(width: 16),
//                           Text(
//                               '${homeProvider.productDetails!.product!.averageReview} ${l10n.ratingLabel}'),
//                         ],
//                       ),
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       Text(
//                         '${homeProvider.productDetails!.product!.unitPrice} Sar',
//                         style:
//                             const TextStyle(fontSize: 20, color: AppColors.red),
//                       ),
//
//                       const SizedBox(
//                         height: 4,
//                       ),
//
//                       Text(
//                         l10n.priceIncludingVAT,
//                         style: const TextStyle(fontSize: 10),
//                       ),
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       ///new colors and sizes section
//                       for (int attributeIndex = 0;
//                           attributeIndex < attributes!.length;
//                           attributeIndex++) ...[
//                         for (int i = 0; i < choiceOptions!.length; i++) ...[
//                           if (attributes[attributeIndex].toString() ==
//                               choiceOptions[i].attributeId) ...[
//                             Text(
//                               choiceOptions[i].title!,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Wrap(
//                               direction: Axis.horizontal,
//                               children: [
//                                 for (int choiceOptionIndex = 0;
//                                     choiceOptionIndex <
//                                         choiceOptions[i].options!.length;
//                                     choiceOptionIndex++) ...[
//                                   InkWell(
//                                     onTap: () {
//                                       if (choiceOptions[i].title == 'Color') {
//                                         for (int j = 0;
//                                             j <
//                                                 choiceOptions[i]
//                                                     .options!
//                                                     .length;
//                                             j++) {
//                                           if (j == choiceOptionIndex) {
//                                             choiceOptions[i]
//                                                 .options![j]
//                                                 .isSelected = true;
//                                           } else {
//                                             choiceOptions[i]
//                                                 .options![j]
//                                                 .isSelected = false;
//                                           }
//                                         }
//
//                                         homeProvider.setSelectedColor(
//                                             choiceOptions[i]
//                                                 .options![choiceOptionIndex]
//                                                 .name!);
//
//                                         print(
//                                             'color: ${homeProvider.getSelectedColor}');
//                                       } else if (choiceOptions[i].title ==
//                                           'Size') {
//                                         for (int j = 0;
//                                             j <
//                                                 choiceOptions[i]
//                                                     .options!
//                                                     .length;
//                                             j++) {
//                                           for (int j = 0;
//                                               j <
//                                                   choiceOptions[i]
//                                                       .options!
//                                                       .length;
//                                               j++) {
//                                             if (j == choiceOptionIndex) {
//                                               choiceOptions[i]
//                                                   .options![j]
//                                                   .isSelected = true;
//                                             } else {
//                                               choiceOptions[i]
//                                                   .options![j]
//                                                   .isSelected = false;
//                                             }
//                                           }
//                                         }
//
//                                         homeProvider.setSelectedSize(
//                                             choiceOptions[i]
//                                                 .options![choiceOptionIndex]
//                                                 .name!);
//                                       }
//
//                                       ///update variant product
//
//                                       for (int j = 0;
//                                           j < choiceOptions[i].options!.length;
//                                           j++) {
//                                         if (choiceOptions[i]
//                                                 .options![j]
//                                                 .isSelected &&
//                                             !selectedChoiceOptions.contains(
//                                                 choiceOptions[i]
//                                                     .options![j]
//                                                     .id
//                                                     .toString())) {
//                                           //add selected choice option id
//
//                                           selectedChoiceOptions.add(
//                                               choiceOptions[i]
//                                                   .options![j]
//                                                   .id
//                                                   .toString());
//
//                                           selectedAttributes[choiceOptions[i]
//                                               .title!] = selectedChoiceOptions;
//                                         }
//                                       }
//
//                                       //join selectedAttributes values
//                                       String selectedChoicesIds =
//                                           selectedAttributes.values
//                                               .expand((element) => element)
//                                               .toList()
//                                               .join(',');
//
//                                       print(
//                                           'selected choice options: $selectedChoicesIds');
//
//                                       //update variant product
//                                       homeProvider.productDetails!.product!
//                                           .variantProducts!
//                                           .forEach((element) {
//                                         print(
//                                             'element: ${element.childAttributeValueIds}');
//
//                                         //if(element.childAttributeValueIds == selectedChoiceOptions.join(',')) {
//                                         if (element.childAttributeValueIds ==
//                                             selectedChoicesIds) {
//                                           print(
//                                               'variant product found: ${element.name}');
//                                           setState(() {
//                                             variantProduct = element;
//                                           });
//                                         }
//                                       });
//
//                                       setState(() {});
//                                     },
//                                     child: Container(
//                                       width: 40,
//                                       height: 40,
//                                       alignment: Alignment.center,
//                                       padding: choiceOptions[i].title == 'Color'
//                                           ? const EdgeInsets.all(1.0)
//                                           : const EdgeInsets.all(8.0),
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 2.0, horizontal: 4.0),
//                                       decoration: BoxDecoration(
//                                         color: choiceOptions[i]
//                                                 .options![choiceOptionIndex]
//                                                 .isSelected
//                                             ? AppColors.selectedOption
//                                                 .withOpacity(0.3)
//                                             : Colors.white,
//                                         shape: choiceOptions[i].title == 'Color'
//                                             ? BoxShape.circle
//                                             : BoxShape.rectangle,
//                                         border: Border.all(
//                                           color: choiceOptions[i]
//                                                   .options![choiceOptionIndex]
//                                                   .isSelected
//                                               ? AppColors.blackColor
//                                               : Colors.transparent,
//                                           width: 1,
//                                         ),
//                                         borderRadius:
//                                             choiceOptions[i].title == 'Color'
//                                                 ? null
//                                                 : BorderRadius.circular(8.0),
//                                       ),
//                                       child: choiceOptions[i].title == 'Color'
//                                           ? ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(60.0),
//                                               child: SvgPicture.network(
//                                                 '${APIs.imageBaseURL}${APIs.attributeValue}${choiceOptions[i].options![choiceOptionIndex].image ?? ''}',
//                                                 width: 40,
//                                                 height: 40,
//                                               ),
//                                             )
//                                           : Text(
//                                               choiceOptions[i]
//                                                   .options![choiceOptionIndex]
//                                                   .name!,
//                                               style: const TextStyle(
//                                                   fontFamily: 'Montserrat',
//                                                   fontSize: 14,
//                                                   color: AppColors.blackColor),
//                                             ),
//                                     ),
//                                   ),
//                                 ],
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ],
//                       ],
//
//                       if (colorIndex != -1) ...[
//                         Text(
//                           l10n.colorLabel,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: AppColors.primaryColor,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Wrap(
//                           direction: Axis.horizontal,
//                           children: [
//                             for (int i = 0;
//                                 i <
//                                     homeProvider
//                                         .productDetails!
//                                         .product!
//                                         .choiceOptions![colorIndex]
//                                         .options!
//                                         .length;
//                                 i++)
//                               InkWell(
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 onTap: () {
//                                   for (int j = 0;
//                                       j <
//                                           homeProvider
//                                               .productDetails!
//                                               .product!
//                                               .choiceOptions![colorIndex]
//                                               .options!
//                                               .length;
//                                       j++) {
//                                     if (j == i) {
//                                       homeProvider
//                                           .productDetails!
//                                           .product!
//                                           .choiceOptions![colorIndex]
//                                           .options![j]
//                                           .isSelected = true;
//                                     } else {
//                                       homeProvider
//                                           .productDetails!
//                                           .product!
//                                           .choiceOptions![colorIndex]
//                                           .options![j]
//                                           .isSelected = false;
//                                     }
//                                   }
//
//                                   homeProvider.setSelectedColor(homeProvider
//                                       .productDetails!
//                                       .product!
//                                       .choiceOptions![colorIndex]
//                                       .options![i]
//                                       .name!);
//
//                                   print(
//                                       'color: ${homeProvider.getSelectedColor}');
//
//                                   setState(() {});
//                                 },
//                                 child: Container(
//                                   width: 40,
//                                   height: 40,
//                                   padding: const EdgeInsets.all(1.0),
//                                   margin: const EdgeInsets.symmetric(
//                                       vertical: 2.0, horizontal: 4.0),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                       color: homeProvider
//                                               .productDetails!
//                                               .product!
//                                               .choiceOptions![colorIndex]
//                                               .options![i]
//                                               .isSelected
//                                           ? AppColors.blackColor
//                                           : Colors.transparent,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(60.0),
//                                     child: SvgPicture.network(
//                                       '${APIs.imageBaseURL}${APIs.attributeValue}${homeProvider.productDetails!.product!.choiceOptions![colorIndex].options![i].image}',
//                                       width: 40,
//                                       height: 40,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ],
//
//                       const SizedBox(
//                         height: 10,
//                       ),
//
//                       Text(
//                         l10n.quantityLabel,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: AppColors.primaryColor,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//
//                       const SizedBox(
//                         height: 10,
//                       ),
//
//                       ///quantity
//                       QuantityWidget(
//                         qty: qty,
//                         qtyDecrement: () {
//                           setState(() {
//                             if (qty > 1) {
//                               qty--;
//                             }
//                           });
//                         },
//                         qtyIncrement: () {
//                           setState(() {
//                             qty++;
//                           });
//                         },
//                       ),
//
//                       const SizedBox(
//                         height: 10,
//                       ),
//
//                       if (sizeIndex != -1) ...[
//                         Text(
//                           l10n.sizeLabel,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: AppColors.primaryColor,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         ///size options
//                         SizeOptions(
//                             choiceOptions: homeProvider.productDetails!.product!
//                                 .choiceOptions![sizeIndex]),
//                       ],
//
//                       const SizedBox(
//                         height: 20,
//                       ),
//
//                       ///shipping info
//                       const ShippingInfo(),
//
//                       const SizedBox(
//                         height: 20,
//                       ),
//
//                       ///add to cart button and price
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: 160,
//                             height: 50,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 List<CartChoices> choicesList = [];
//                                 String choiceStr = '';
//
//                                 for (int i = 0;
//                                     i <
//                                         homeProvider.productDetails!.product!
//                                             .choiceOptions!.length;
//                                     i++) {
//                                   for (int j = 0;
//                                       j <
//                                           homeProvider
//                                               .productDetails!
//                                               .product!
//                                               .choiceOptions![i]
//                                               .options!
//                                               .length;
//                                       j++) {
//                                     if (homeProvider
//                                             .productDetails!
//                                             .product!
//                                             .choiceOptions![i]
//                                             .options![j]
//                                             .isSelected ==
//                                         true) {
//                                       choicesList.add(CartChoices(
//                                         name: homeProvider
//                                             .productDetails!
//                                             .product!
//                                             .choiceOptions![i]
//                                             .options![j]
//                                             .name!,
//                                         attributeName: homeProvider
//                                             .productDetails!
//                                             .product!
//                                             .choiceOptions![i]
//                                             .title!,
//                                         attributeChoice: homeProvider
//                                             .productDetails!
//                                             .product!
//                                             .choiceOptions![i]
//                                             .name!,
//                                         id: homeProvider
//                                             .productDetails!
//                                             .product!
//                                             .choiceOptions![i]
//                                             .options![j]
//                                             .id!,
//                                         attributeId: homeProvider
//                                             .productDetails!
//                                             .product!
//                                             .choiceOptions![i]
//                                             .options![j]
//                                             .attributeId!,
//                                       ));
//
//                                       choiceStr +=
//                                           '${homeProvider.productDetails!.product!.choiceOptions![i].options![j].id!}-';
//                                     }
//                                   }
//                                 }
//
//                                 if (choiceStr.length > 1) {
//                                   //remove last character
//                                   choiceStr = choiceStr.substring(
//                                       0, choiceStr.length - 1);
//                                 }
//
//                                 print('choice str: $choiceStr');
//                                 // if(homeProvider.productDetails!.variation != null && homeProvider.productDetails!.variation!.isNotEmpty) {
//                                 //   int variationQty = homeProvider.productDetails!.variation!.where((element)
//                                 if (homeProvider.productDetails!.product!
//                                             .variantProducts !=
//                                         null &&
//                                     homeProvider.productDetails!.product!
//                                         .variantProducts!.isNotEmpty) {
//                                   int variationQty = homeProvider
//                                           .productDetails!
//                                           .product!
//                                           .variantProducts!
//                                           .where((element)
//
//                                               //=> element.attributeValueId == choiceStr).first.qty!;
//                                               =>
//                                               element.id.toString() ==
//                                               choiceStr)
//                                           .firstOrNull
//                                           ?.currentStock! ??
//                                       0;
//
//                                   print('qty : $variationQty');
//
//                                   if (variationQty == 0) {
//                                     Utils.toast('Out of stock');
//                                     return;
//                                   } else if (variationQty < qty) {
//                                     Utils.toast(
//                                         'Only $variationQty left in stock');
//
//                                     setState(() {
//                                       qty = variationQty;
//                                     });
//
//                                     return;
//                                   }
//                                 }
//
//                                 CartProduct cartProduct = CartProduct(
//                                     id: homeProvider
//                                         .productDetails!.product!.id!,
//                                     title: homeProvider
//                                         .productDetails!.product!.name!,
//                                     brand: homeProvider
//                                         .productDetails!.product!.brand!.name!,
//                                     image: homeProvider
//                                         .productDetails!.product!.thumbnail!,
//                                     totalPrice: homeProvider.productDetails!
//                                             .product!.unitPrice! *
//                                         qty,
//                                     unitPrice: homeProvider
//                                         .productDetails!.product!.unitPrice!,
//                                     quantity: qty,
//                                     slug: homeProvider
//                                         .productDetails!.product!.slug!,
//                                     currentSock: homeProvider
//                                         .productDetails!.product!.currentStock!,
//                                     choiceString: choiceStr,
//                                     choices: choicesList);
//
//                                 await SharedPref.addCartProduct(cartProduct);
//
//                                 await cartProvider.getCartProducts();
//
//                                 /*final cartProductsList = checkoutProvider.getPlaceOrderModel.cartProducts;
//                                 cartProductsList?.add(cartProduct);
//                                 checkoutProvider.getPlaceOrderModel.copyWith(cartProducts: cartProductsList);
//
//                                 print('place order model: ${checkoutProvider.getPlaceOrderModel.toJson()}');*/
//
//                                 if (mounted) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => const MyBagScreen(),
//                                     ),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 elevation: 0,
//                                 shadowColor: Colors.transparent,
//                                 side: const BorderSide(
//                                   width: 1.0,
//                                   color: AppColors.red,
//                                 ),
//                                 backgroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(60.0),
//                                 ),
//                               ),
//                               child: Text(
//                                 l10n.addToCartBtnText,
//                                 style: const TextStyle(color: AppColors.red),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '${l10n.productCode}: ${homeProvider.productDetails!.product!.code}',
//                             style: const TextStyle(
//                                 fontSize: 12,
//                                 fontFamily: 'Montserrat',
//                                 fontWeight: FontWeight.w300,
//                                 color: AppColors.blackColor),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(
//                         height: 20,
//                       ),
//
//                       Text(
//                         '${homeProvider.productDetails!.product!.name}',
//                         style: const TextStyle(
//                             fontSize: 18,
//                             color: AppColors.primaryColor,
//                             fontWeight: FontWeight.bold),
//                       ),
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       ///product info, sizes, and customer reviews tabs
//                       DescriptionSizesReviewsTabs(
//                         descriptionCallback: () {
//                           setState(() {
//                             productInfo = ProductInfo.description;
//                           });
//                         },
//                         sizesCallback: () {
//                           setState(() {
//                             productInfo = ProductInfo.sizes;
//                           });
//                         },
//                         reviewsCallback: () {
//                           setState(() {
//                             productInfo = ProductInfo.reviews;
//                           });
//                         },
//                         productInfo: productInfo,
//                       ),
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       productDetailsWidget,
//
//                       const SizedBox(
//                         height: 16,
//                       ),
//
//                       /*if(homeProvider
//                           .productDetails!.similarProducts == null ) ...[
//
//                             const SizedBox(),
//
//                     ],*/
//
//                       if (homeProvider
//                                   .productDetails!.product!.similarProducts !=
//                               null &&
//                           homeProvider.productDetails!.product!.similarProducts!
//                               .isNotEmpty) ...[
//                         Text(l10n.similarProductsLabel,
//                             style: const TextStyle(
//                                 fontSize: 18,
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.bold)),
//
//                         const SizedBox(
//                           height: 8,
//                         ),
//
//                         ///similar products
//                         SimilarProducts(
//                           slug: widget.slug,
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
