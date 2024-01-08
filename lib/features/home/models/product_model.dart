import 'package:labees/features/home/models/attribute_detail.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/home/models/tag.dart';

class ProductModel {

  Category? category;
  ProductData? products;
  List<SubCategories>? subCategories;
  List<Brand>? brands;

  List<Tag>? tags;
  List<AttributeDetails>? attributes;


  bool? success;
  String? message;

  ProductModel(
      {
        this.category,
        this.products,
        this.subCategories,
        this.brands,
        this.tags,
        this.attributes,
        this.success = false,
        this.message
      });

  ProductModel.fromJson(Map<String, dynamic> json) {

    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;

    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }

    if (json['brands'] != null) {
      brands = <Brand>[];
      json['brands'].forEach((v) {
        brands!.add(Brand.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(new Tag.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <AttributeDetails>[];
      json['attributes'].forEach((v) {
        attributes!.add(new AttributeDetails.fromJson(v));
      });
    }

    products = json['products'] != null
        ? ProductData.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }

    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }

    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }

    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }

    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }

    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? homeStatus;
  int? topCategory;
  int? status;
  int? priority;

  Category(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.parentId,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.homeStatus,
        this.topCategory,
        this.status,
        this.priority,
      });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
    topCategory = json['top_category'];
    status = json['status'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['home_status'] = this.homeStatus;
    data['top_category'] = this.topCategory;
    data['status'] = this.status;
    data['priority'] = this.priority;
    return data;
  }
}

class ProductData {
  int? totalSize;
  int? limit;
  int? offset;
  List<Products>? products;

  ProductData({this.totalSize, this.limit, this.offset, this.products});

  ProductData.fromJson(Map<String, dynamic> json) {
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


class SubCategories {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? homeStatus;
  int? topCategory;
  int? status;
  int? priority;

  bool isSelected = false;

  SubCategories(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.parentId,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.homeStatus,
        this.topCategory,
        this.status,
        this.priority,
        this.isSelected = false,
      });

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
    topCategory = json['top_category'];
    status = json['status'];
    priority = json['priority'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['home_status'] = this.homeStatus;
    data['top_category'] = this.topCategory;
    data['status'] = this.status;
    data['priority'] = this.priority;

    return data;
  }
}








