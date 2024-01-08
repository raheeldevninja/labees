class MyPointsResponse {
  int? limit;
  int? offset;
  int? totalLoyaltyPoint;
  int? totalLoyalty;
  List<LoyaltyPointList>? loyaltyPointList;

  bool? status;
  String? message;

  MyPointsResponse(
      {this.limit,
        this.offset,
        this.totalLoyaltyPoint,
        this.totalLoyalty,
        this.loyaltyPointList,
        this.status,
        this.message
      });

  MyPointsResponse.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    totalLoyaltyPoint = json['total_loyalty_point'];
    totalLoyalty = json['total_loyalty'];
    if (json['loyalty_point_list'] != null) {
      loyaltyPointList = <LoyaltyPointList>[];
      json['loyalty_point_list'].forEach((v) {
        loyaltyPointList!.add(new LoyaltyPointList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['total_loyalty_point'] = this.totalLoyaltyPoint;
    data['total_loyalty'] = this.totalLoyalty;
    if (this.loyaltyPointList != null) {
      data['loyalty_point_list'] =
          this.loyaltyPointList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoyaltyPointList {
  int? id;
  int? userId;
  String? transactionId;
  int? credit;
  int? debit;
  int? balance;
  String? reference;
  String? transactionType;
  int? usedStatus;
  int? remaining;
  int? isExpired;
  String? createdAt;
  String? updatedAt;
  String? expiry;

  LoyaltyPointList(
      {this.id,
        this.userId,
        this.transactionId,
        this.credit,
        this.debit,
        this.balance,
        this.reference,
        this.transactionType,
        this.usedStatus,
        this.remaining,
        this.isExpired,
        this.createdAt,
        this.updatedAt,
        this.expiry});

  LoyaltyPointList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    credit = json['credit'];
    debit = json['debit'];
    balance = json['balance'];
    reference = json['reference'];
    transactionType = json['transaction_type'];
    usedStatus = json['used_status'];
    remaining = json['remaining'];
    isExpired = json['is_expired'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['balance'] = this.balance;
    data['reference'] = this.reference;
    data['transaction_type'] = this.transactionType;
    data['used_status'] = this.usedStatus;
    data['remaining'] = this.remaining;
    data['is_expired'] = this.isExpired;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['expiry'] = this.expiry;
    return data;
  }
}
