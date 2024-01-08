class ShippingMethods {

  bool success = false;
  String? message;
  List<ShippingMethod>? data;

  ShippingMethods({this.success = false, this.message, this.data});

}

class ShippingMethod {
  int? id;
  int? creatorId;
  String? creatorType;
  String? title;
  int? cost;
  String? duration;
  int? status;
  String? createdAt;
  String? updatedAt;


  ShippingMethod({
        this.id,
        this.creatorId,
        this.creatorType,
        this.title,
        this.cost,
        this.duration,
        this.status,
        this.createdAt,
        this.updatedAt,
      });

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    creatorType = json['creator_type'];
    title = json['title'];
    cost = json['cost'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['creator_id'] = this.creatorId;
    data['creator_type'] = this.creatorType;
    data['title'] = this.title;
    data['cost'] = this.cost;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
