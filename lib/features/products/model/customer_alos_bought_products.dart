import 'package:labees/features/home/models/attribute_detail.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/models/category_ids.dart';
import 'package:labees/features/home/models/choice_option.dart';
import 'package:labees/features/home/models/review.dart';
import 'package:labees/features/home/models/tag.dart';
import 'package:labees/features/home/models/variation.dart';
import 'package:labees/features/home/models/wish_list.dart';

class CustomersAlsoBoughtProducts {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  String? productType;
  List<CategoryIds>? categoryIds;
  String? categories;
  int? brandId;
  String? unit;
  int? minQty;
  int? refundable;
  Null? digitalProductType;
  Null? digitalFileReady;
  List<String>? images;
  String? thumbnail;
  Null? hoverThumbnail;
  int? featured;
  Null? flashDeal;
  String? videoProvider;
  String? videoUrl;
  String? colors;
  String? tags;
  String? similarProducts;
  String? customersAlsoBoughtProducts;
  int? variantProduct;
  List<ChoiceOptions>? choiceOptions;
  List<Variation>? variation;
  int? published;
  int? unitPrice;
  int? purchasePrice;
  int? tax;
  String? taxType;
  int? discount;
  Null? discountType;
  int? currentStock;
  int? minimumOrderQty;
  String? shortDescription;
  String? details;
  String? sizes;
  int? freeShipping;
  Null? attachment;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;
  Null? deniedNote;
  int? shippingCost;
  int? multiplyQty;
  Null? tempShippingCost;
  Null? isShippingCostUpdated;
  String? code;
  int? qualityScore;
  Null? referenceSku;
  int? reviewsCount;
  List<Null>? colorsFormatted;
  List<AttributeDetails>? attributeDetails;
  Wishlist? wishlist;
  List<Tag>? tagDetails;
  Brand? brand;
  List<Reviews>? reviews;

  CustomersAlsoBoughtProducts(
      {this.id,
      this.addedBy,
      this.userId,
      this.name,
      this.slug,
      this.productType,
      this.categoryIds,
      this.categories,
      this.brandId,
      this.unit,
      this.minQty,
      this.refundable,
      this.digitalProductType,
      this.digitalFileReady,
      this.images,
      this.thumbnail,
      this.hoverThumbnail,
      this.featured,
      this.flashDeal,
      this.videoProvider,
      this.videoUrl,
      this.colors,
      this.tags,
      this.similarProducts,
      this.customersAlsoBoughtProducts,
      this.variantProduct,
      this.choiceOptions,
      this.variation,
      this.published,
      this.unitPrice,
      this.purchasePrice,
      this.tax,
      this.taxType,
      this.discount,
      this.discountType,
      this.currentStock,
      this.minimumOrderQty,
      this.shortDescription,
      this.details,
      this.sizes,
      this.freeShipping,
      this.attachment,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.featuredStatus,
      this.metaTitle,
      this.metaDescription,
      this.metaImage,
      this.requestStatus,
      this.deniedNote,
      this.shippingCost,
      this.multiplyQty,
      this.tempShippingCost,
      this.isShippingCostUpdated,
      this.code,
      this.qualityScore,
      this.referenceSku,
      this.reviewsCount,
      this.colorsFormatted,
      this.attributeDetails,
      this.wishlist,
      this.tagDetails,
      this.brand,
      this.reviews});

  CustomersAlsoBoughtProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    productType = json['product_type'];
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(new CategoryIds.fromJson(v));
      });
    }
    categories = json['categories'];
    brandId = json['brand_id'];
    unit = json['unit'];
    minQty = json['min_qty'];
    refundable = json['refundable'];
    digitalProductType = json['digital_product_type'];
    digitalFileReady = json['digital_file_ready'];
    images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
    hoverThumbnail = json['hover_thumbnail'];
    featured = json['featured'];
    flashDeal = json['flash_deal'];
    videoProvider = json['video_provider'];
    videoUrl = json['video_url'];
    colors = json['colors'];
    tags = json['tags'];
    similarProducts = json['similar_products'];
    customersAlsoBoughtProducts = json['customers_also_bought_products'];
    variantProduct = json['variant_product'];
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(new ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(Variation.fromJson(v));
      });
    }
    published = json['published'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    minimumOrderQty = json['minimum_order_qty'];
    shortDescription = json['short_description'];
    details = json['details'];
    sizes = json['sizes'];
    freeShipping = json['free_shipping'];
    attachment = json['attachment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    featuredStatus = json['featured_status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    requestStatus = json['request_status'];
    deniedNote = json['denied_note'];
    shippingCost = json['shipping_cost'];
    multiplyQty = json['multiply_qty'];
    tempShippingCost = json['temp_shipping_cost'];
    isShippingCostUpdated = json['is_shipping_cost_updated'];
    code = json['code'];
    qualityScore = json['quality_score'];
    referenceSku = json['reference_sku'];
    reviewsCount = json['reviews_count'];
    if (json['attribute_details'] != null) {
      attributeDetails = <AttributeDetails>[];
      json['attribute_details'].forEach((v) {
        attributeDetails!.add(AttributeDetails.fromJson(v));
      });
    }

    wishlist =
        json['wishlist'] != null ? Wishlist.fromJson(json['wishlist']) : null;

    if (json['tag_details'] != null) {
      tagDetails = <Tag>[];
      json['tag_details'].forEach((v) {
        tagDetails!.add(new Tag.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['product_type'] = this.productType;
    if (this.categoryIds != null) {
      data['category_ids'] = this.categoryIds!.map((v) => v.toJson()).toList();
    }
    data['categories'] = this.categories;
    data['brand_id'] = this.brandId;
    data['unit'] = this.unit;
    data['min_qty'] = this.minQty;
    data['refundable'] = this.refundable;
    data['digital_product_type'] = this.digitalProductType;
    data['digital_file_ready'] = this.digitalFileReady;
    data['images'] = this.images;
    data['thumbnail'] = this.thumbnail;
    data['hover_thumbnail'] = this.hoverThumbnail;
    data['featured'] = this.featured;
    data['flash_deal'] = this.flashDeal;
    data['video_provider'] = this.videoProvider;
    data['video_url'] = this.videoUrl;
    data['colors'] = this.colors;
    data['tags'] = this.tags;
    data['similar_products'] = this.similarProducts;
    data['customers_also_bought_products'] = this.customersAlsoBoughtProducts;
    data['variant_product'] = this.variantProduct;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    }
    data['published'] = this.published;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['current_stock'] = this.currentStock;
    data['minimum_order_qty'] = this.minimumOrderQty;
    data['short_description'] = this.shortDescription;
    data['details'] = this.details;
    data['sizes'] = this.sizes;
    data['free_shipping'] = this.freeShipping;
    data['attachment'] = this.attachment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['featured_status'] = this.featuredStatus;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_image'] = this.metaImage;
    data['request_status'] = this.requestStatus;
    data['denied_note'] = this.deniedNote;
    data['shipping_cost'] = this.shippingCost;
    data['multiply_qty'] = this.multiplyQty;
    data['temp_shipping_cost'] = this.tempShippingCost;
    data['is_shipping_cost_updated'] = this.isShippingCostUpdated;
    data['code'] = this.code;
    data['quality_score'] = this.qualityScore;
    data['reference_sku'] = this.referenceSku;
    data['reviews_count'] = this.reviewsCount;
    if (this.attributeDetails != null) {
      data['attribute_details'] =
          this.attributeDetails!.map((v) => v.toJson()).toList();
    }
    data['wishlist'] = this.wishlist;
    if (this.tagDetails != null) {
      data['tag_details'] = this.tagDetails!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }

    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
