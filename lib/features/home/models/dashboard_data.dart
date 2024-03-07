import 'package:labees/features/home/models/product.dart';

class DashboardData {
  NewArrivalProducts? newArrivalProducts;
  List<MostWantedBanners>? mostWantedBanners;

  bool? success;
  String? message;

  DashboardData(
      {this.newArrivalProducts,
        this.mostWantedBanners,
        this.success,
        this.message
      });

  DashboardData.fromJson(Map<String, dynamic> json) {
    newArrivalProducts = json['new_arrival_products'] != null
        ? NewArrivalProducts.fromJson(json['new_arrival_products'])
        : null;
    if (json['most_wanted_banners'] != null) {
      mostWantedBanners = <MostWantedBanners>[];
      json['most_wanted_banners'].forEach((v) {
        mostWantedBanners!.add(MostWantedBanners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.newArrivalProducts != null) {
      data['new_arrival_products'] = this.newArrivalProducts!.toJson();
    }
    if (this.mostWantedBanners != null) {
      data['most_wanted_banners'] =
          this.mostWantedBanners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewArrivalProducts {
  int? totalSize;
  int? limit;
  int? offset;
  List<Products>? products;

  NewArrivalProducts({this.totalSize, this.limit, this.offset, this.products});

  NewArrivalProducts.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MostWantedBanners {
  int? id;
  String? photo;
  String? photoAr;
  String? title;
  String? subTitle;
  String? bannerType;
  int? featuredBannerSize;
  String? featuredBannerColor;
  int? featuredBannerTextColor;
  int? published;
  String? createdAt;
  String? updatedAt;
  int? urlType;
  String? url;
  String? resourceType;
  int? resourceId;

  MostWantedBanners(
      {this.id,
        this.photo,
        this.photoAr,
        this.title,
        this.subTitle,
        this.bannerType,
        this.featuredBannerSize,
        this.featuredBannerColor,
        this.featuredBannerTextColor,
        this.published,
        this.createdAt,
        this.updatedAt,
        this.urlType,
        this.url,
        this.resourceType,
        this.resourceId});

  MostWantedBanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    photoAr = json['photo_ar'];
    title = json['title'];
    subTitle = json['sub_title'];
    bannerType = json['banner_type'];
    featuredBannerSize = json['featured_banner_size'];
    featuredBannerColor = json['featured_banner_color'];
    featuredBannerTextColor = json['featured_banner_text_color'];
    published = json['published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    urlType = json['url_type'];
    url = json['url'];
    resourceType = json['resource_type'];
    resourceId = json['resource_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['photo_ar'] = this.photoAr;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['banner_type'] = this.bannerType;
    data['featured_banner_size'] = this.featuredBannerSize;
    data['featured_banner_color'] = this.featuredBannerColor;
    data['featured_banner_text_color'] = this.featuredBannerTextColor;
    data['published'] = this.published;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url_type'] = this.urlType;
    data['url'] = this.url;
    data['resource_type'] = this.resourceType;
    data['resource_id'] = this.resourceId;

    return data;
  }
}