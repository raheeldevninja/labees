class AccountSettingsResponse {
  int? walletStatus;
  int? loyaltyPointStatus;
  int? loyaltyPointExchangeRate;
  int? loyaltyPointMinimumPoint;

  bool? status;
  String? message;

  AccountSettingsResponse(
      {this.walletStatus,
        this.loyaltyPointStatus,
        this.loyaltyPointExchangeRate,
        this.loyaltyPointMinimumPoint,
        this.status,
        this.message
      });

  AccountSettingsResponse.fromJson(Map<String, dynamic> json) {
    walletStatus = json['wallet_status'];
    loyaltyPointStatus = json['loyalty_point_status'];
    loyaltyPointExchangeRate = json['loyalty_point_exchange_rate'];
    loyaltyPointMinimumPoint = json['loyalty_point_minimum_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['wallet_status'] = this.walletStatus;
    data['loyalty_point_status'] = this.loyaltyPointStatus;
    data['loyalty_point_exchange_rate'] = this.loyaltyPointExchangeRate;
    data['loyalty_point_minimum_point'] = this.loyaltyPointMinimumPoint;
    return data;
  }
}
