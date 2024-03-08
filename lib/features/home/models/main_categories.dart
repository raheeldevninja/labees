import 'package:labees/features/home/models/categories.dart';

class MainCategories {
  List<Categories>? categories;

  bool? success;
  String? message;

  MainCategories({this.categories, this.success = false, this.message});

  MainCategories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
