class FooterSettingsResponse {
  List<Pages>? pages;
  List<SocialMediaLinks>? socialMediaLinks;
  AppStoreLink? appStoreLink;
  AppStoreLink? playStoreLink;
  int? sellerRegistration;
  List<TopCategories>? topCategories;
  List<PaymentMethodLogos>? paymentMethodLogos;

  bool? success;
  String? message;

  FooterSettingsResponse(
      {this.pages,
        this.socialMediaLinks,
        this.appStoreLink,
        this.playStoreLink,
        this.sellerRegistration,
        this.topCategories,
        this.paymentMethodLogos,
        this.success,
        this.message,
      });

  FooterSettingsResponse.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
    if (json['social_media_links'] != null) {
      socialMediaLinks = <SocialMediaLinks>[];
      json['social_media_links'].forEach((v) {
        socialMediaLinks!.add(new SocialMediaLinks.fromJson(v));
      });
    }
    appStoreLink = json['app_store_link'] != null
        ? new AppStoreLink.fromJson(json['app_store_link'])
        : null;
    playStoreLink = json['play_store_link'] != null
        ? new AppStoreLink.fromJson(json['play_store_link'])
        : null;
    sellerRegistration = json['seller_registration'];
    if (json['top_categories'] != null) {
      topCategories = <TopCategories>[];
      json['top_categories'].forEach((v) {
        topCategories!.add(new TopCategories.fromJson(v));
      });
    }
    if (json['payment_method_logos'] != null) {
      paymentMethodLogos = <PaymentMethodLogos>[];
      json['payment_method_logos'].forEach((v) {
        paymentMethodLogos!.add(new PaymentMethodLogos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    if (this.socialMediaLinks != null) {
      data['social_media_links'] =
          this.socialMediaLinks!.map((v) => v.toJson()).toList();
    }
    if (this.appStoreLink != null) {
      data['app_store_link'] = this.appStoreLink!.toJson();
    }
    if (this.playStoreLink != null) {
      data['play_store_link'] = this.playStoreLink!.toJson();
    }
    data['seller_registration'] = this.sellerRegistration;
    if (this.topCategories != null) {
      data['top_categories'] =
          this.topCategories!.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethodLogos != null) {
      data['payment_method_logos'] =
          this.paymentMethodLogos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pages {
  int? id;
  String? name;
  String? description;
  String? slug;
  int? status;
  String? createdAt;
  String? updatedAt;

  Pages(
      {this.id,
        this.name,
        this.description,
        this.slug,
        this.status,
        this.createdAt,
        this.updatedAt});

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

class SocialMediaLinks {
  int? id;
  String? name;
  String? link;
  String? icon;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Null>? translations;

  SocialMediaLinks(
      {this.id,
        this.name,
        this.link,
        this.icon,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.translations});

  SocialMediaLinks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    icon = json['icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    data['icon'] = this.icon;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

class AppStoreLink {
  String? status;
  String? link;

  AppStoreLink({this.status, this.link});

  AppStoreLink.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['link'] = this.link;
    return data;
  }
}

class TopCategories {
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

  TopCategories(
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

  TopCategories.fromJson(Map<String, dynamic> json) {
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

class PaymentMethodLogos {
  int? id;
  String? name;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Null>? translations;

  PaymentMethodLogos(
      {this.id,
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.translations});

  PaymentMethodLogos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}
