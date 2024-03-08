import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/models/childes.dart';

class CategoryChild {
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
  List<Brand>? brands;

  List<Childes>? childes;

  bool? isSelected = false;

  CategoryChild({
    this.id,
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
    this.brands,
    this.childes,
    this.isSelected = false,
  });

  CategoryChild copyWith({
    int? id,
    String? name,
    String? slug,
    String? icon,
    int? parentId,
    int? position,
    String? createdAt,
    String? updatedAt,
    int? homeStatus,
    int? topCategory,
    int? status,
    int? priority,
    List<Brand>? brands,
    bool? isSelected,
  }) {
    return CategoryChild(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      parentId: parentId ?? this.parentId,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      homeStatus: homeStatus ?? this.homeStatus,
      topCategory: topCategory ?? this.topCategory,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      brands: brands ?? this.brands,
      childes: childes ?? this.childes,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  CategoryChild.fromJson(Map<String, dynamic> json) {
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
    if (json['brands'] != null) {
      brands = <Brand>[];
      json['brands'].forEach((v) {
        brands!.add(Brand.fromJson(v));
      });
    }
    if (json['childes'] != null) {
      childes = <Childes>[];
      json['childes'].forEach((v) {
        childes!.add(Childes.fromJson(v));
      });
    }
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
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.childes != null) {
      data['childes'] = this.childes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
