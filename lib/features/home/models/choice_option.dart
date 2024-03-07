import 'package:labees/features/home/models/option.dart';

/*
class ChoiceOptions {
  String? title;
  String? name;
  List<Options>? options;

  ChoiceOptions({this.title, this.name, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
*/


class ChoiceOptions {
  String? attributeId;
  String? title;
  String? name;
  List<Options>? options;

  ChoiceOptions({this.attributeId, this.title, this.name, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    title = json['title'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attributeId;
    data['title'] = this.title;
    data['name'] = this.name;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}