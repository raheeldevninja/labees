class WalletResponse {
  int? limit;
  int? offset;
  double? totalWalletBalance;
  int? totalWalletTransactio;
  List<WalletTransactioList>? walletTransactioList;

  bool? status;
  String? message;

  WalletResponse(
      {this.limit,
      this.offset,
      this.totalWalletBalance,
      this.totalWalletTransactio,
      this.walletTransactioList,
      this.status,
      this.message});

  WalletResponse.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    totalWalletBalance = json['total_wallet_balance']?.toDouble() ?? 0.0;
    totalWalletTransactio = json['total_wallet_transactio'];
    if (json['wallet_transactio_list'] != null) {
      walletTransactioList = <WalletTransactioList>[];
      json['wallet_transactio_list'].forEach((v) {
        walletTransactioList!.add(new WalletTransactioList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['total_wallet_balance'] = this.totalWalletBalance;
    data['total_wallet_transactio'] = this.totalWalletTransactio;
    if (this.walletTransactioList != null) {
      data['wallet_transactio_list'] =
          this.walletTransactioList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactioList {
  int? id;
  int? userId;
  String? transactionId;
  int? credit;
  int? debit;
  int? adminBonus;
  double? balance;
  String? transactionType;
  String? reference;
  String? createdAt;
  String? updatedAt;

  WalletTransactioList(
      {this.id,
      this.userId,
      this.transactionId,
      this.credit,
      this.debit,
      this.adminBonus,
      this.balance,
      this.transactionType,
      this.reference,
      this.createdAt,
      this.updatedAt});

  WalletTransactioList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    credit = json['credit'];
    debit = json['debit'];
    adminBonus = json['admin_bonus'];
    balance = json['balance']?.toDouble() ?? 0.0;
    transactionType = json['transaction_type'];
    reference = json['reference'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['admin_bonus'] = this.adminBonus;
    data['balance'] = this.balance;
    data['transaction_type'] = this.transactionType;
    data['reference'] = this.reference;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
