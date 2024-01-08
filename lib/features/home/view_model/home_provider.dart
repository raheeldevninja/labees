import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labees/core/enums/product_info.dart';
import 'package:labees/core/models/all_wishlist_products.dart';
import 'package:labees/core/util/utils.dart';
import 'package:labees/features/home/models/attribute_detail.dart';
import 'package:labees/features/home/models/brand.dart';
import 'package:labees/features/home/models/categories.dart';
import 'package:labees/features/home/models/category_child.dart';
import 'package:labees/features/home/models/childes.dart';
import 'package:labees/features/home/models/dashboard_data.dart';
import 'package:labees/features/home/models/get_wishlist.dart';
import 'package:labees/features/home/models/main_categories.dart';
import 'package:labees/features/home/models/product.dart';
import 'package:labees/features/home/models/product_model.dart';
import 'package:labees/features/home/models/tag.dart';
import 'package:labees/features/home/service/home_service.dart';
import 'package:labees/features/products/model/add_wish_list_response.dart';
import 'package:labees/features/products/model/product_details.dart';
import 'package:labees/features/products/model/wish_list_remove_response.dart';


class HomeProvider extends ChangeNotifier {

  bool isLoading = false;
  late MainCategories mainCategories;
  late DashboardData dashboardData;
  late List<GetWishlist> getWishlistData;

  late NewArrivalProducts newArrivalProducts;
  NewArrivalProducts get getNewArrivalProducts => newArrivalProducts;

  late List<MostWantedBanners> mostWantedBanners;
  List<MostWantedBanners> get getMostWantedBanners => mostWantedBanners;


  MainCategories get getMainCategoriesList => mainCategories;


  String? mainCategory;

  int selectedCategoryIndex = 0;

  ProductInfo productInfo = ProductInfo.description;




  setSelectedCategoryIndex(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  int get getSelectedCategoryIndex => selectedCategoryIndex;


  bool get getIsLoading => isLoading;

  List<Categories>? categories;
  List<CategoryChild>? categoryChildren = [];
  List<Childes>? childsList = [];

  List<Categories>? get getCategories => categories;
  List<CategoryChild>? get getCategoryChildren => categoryChildren;
  List<Childes>? get getChildsList => childsList;

  List<Brand> allBrandsList = [];

  List<Brand> getCategoryChildBrands() {

    for (var element in categoryChildren!) {
      List<Brand> tempBrands = [];
      tempBrands = element.brands!;

      for(int i=0; i<tempBrands.length; i++) {
        if(!allBrandsList.contains(tempBrands[i])) {
          allBrandsList.add(tempBrands[i]);
        }
      }

    }

    return allBrandsList;
  }

  List<ProductData> productData = [];

  List<Products>? products = [];
  List<SubCategories>? subCategories = [];
  List<Brand>? brandsList = [];
  List<Tag>? tags = [];
  List<AttributeDetails>? attributes = [];

  ProductModel? productModel;

  ProductDetails? productDetails;
  AddWishListResponse? addWishListResponse;
  WishListRemoveResponse? wishListRemoveResponse;

  int? colorIndex;
  int? sizeIndex;

  List<SubCategories>? get getSubCategories => subCategories;
  List<Brand>? get getBrands => brandsList;

  setCategoryChildren(List<CategoryChild> categoryChild) {
    categoryChildren = categoryChild;
    notifyListeners();
  }

  setMainCategory(String mainCategory) {
     this.mainCategory = mainCategory;
     notifyListeners();
  }

  String? get getMainCategory => mainCategory;


  setChildList(List<Childes>? cl) {
    childsList = cl;
    notifyListeners();
  }


  Future<void> getMainCategories(BuildContext context, String lang) async {

    //EasyLoading.show(status: 'loading...');
    showLoading();

    mainCategories = await HomeService.getMainCategories(lang);

    if (mainCategories.success!) {
      categories = mainCategories.categories;
      categoryChildren = mainCategories.categories!.first.childes;
    }
    else {
      print('home provider: ${mainCategories.message}');
      Utils.toast(mainCategories.message!);

    }


    //EasyLoading.dismiss();
    hideLoading();
    notifyListeners();

  }


  Future<void> getDashboardData(BuildContext context, bool showShimmer, String lang, int categoryId, String allowedData) async {

    if(showShimmer) {
      showLoading();
    }

    dashboardData = await HomeService.getDashboardData(lang, categoryId, allowedData);

    if (dashboardData.success!) {
      newArrivalProducts = dashboardData.newArrivalProducts!;
      mostWantedBanners = dashboardData.mostWantedBanners!;
    }
    else {
      Utils.toast(dashboardData.message!);
    }

    if(showShimmer) {
      hideLoading();
    }

    notifyListeners();
  }


  Future<void> getProducts(BuildContext context, String lang, int id,
      int limit, int offset, String sort,
      {String? minAmount, String? maxAmount, List<SubCategories>? subCategoriesList, List<Brand> ? brands,
        List<AttributeValues>? sizeAttributes,
        List<AttributeValues>? colorAttributes,
        List<AttributeValues>? ukSizeAttributes,
        bool showShimmer = true,
      }) async {
      //{FilterData? filterData}) async {

    //EasyLoading.show(status: 'loading...');

    products = [];

    if(showShimmer) {
      showLoading();
    }


    productModel = await HomeService.getProducts(lang, id, limit, offset, sort,
        minAmount: minAmount, maxAmount: maxAmount, subCategories: subCategoriesList, brands: brands,
        sizeAttributes: sizeAttributes,
        colorAttributes: colorAttributes,
        ukSizeAttributes: ukSizeAttributes,
    );


    if (productModel!.success!) {

      products = productModel!.products!.products;

      subCategories = productModel!.subCategories;
      brandsList = productModel!.brands;
      tags = productModel!.tags;
      attributes = productModel!.attributes;

    }
    else {
      Utils.toast(productModel!.message!);
    }

    if(showShimmer) {
      hideLoading();
    }
    notifyListeners();

  }


  Future<void> getProductDetails(BuildContext context, String lang, String slug) async {

    //EasyLoading.show(status: 'loading...');
    showLoading();

    productDetails = await HomeService.getProductDetails(lang, slug);

    if (productDetails!.success!) {

    }
    else {
      Utils.toast(productDetails!.message!);
    }

    //EasyLoading.dismiss();
    hideLoading();
    notifyListeners();

  }


  Future<void> addToWishList(BuildContext context, String lang, int productId) async {

    EasyLoading.show();
    //showLoading();

    addWishListResponse = await HomeService.addToWishlist(lang, productId);

    if (addWishListResponse!.success!) {
      //Utils.toast(addWishListResponse!.message!);
    }
    else {
      //Utils.toast(addWishListResponse!.message!);
    }

    //hideLoading();
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> removeFromWishlist(int productId) async {
    EasyLoading.show(status: 'loading...');
    //showLoading();

    wishListRemoveResponse = await HomeService.removeFromWishlist(productId);

    if (wishListRemoveResponse!.success!) {
      //Utils.toast(wishListRemoveResponse!.message!);
    } else {
      Utils.toast(wishListRemoveResponse!.message!);
    }

    EasyLoading.dismiss();
    //hideLoading();
    notifyListeners();
  }


  Future<void> getWishlist(BuildContext context, String lang) async {

    AllWishlistProducts allWishlistProducts = AllWishlistProducts();

    showLoading();

    allWishlistProducts = await HomeService.getWishlist(lang);

    if (allWishlistProducts.success!) {
      getWishlistData = allWishlistProducts.wishlistProducts!;
    }
    else {
      Utils.toast(allWishlistProducts.message!);
    }


      hideLoading();


    notifyListeners();
  }


  int getColorIndex() {

    if(productDetails == null || productDetails!.choiceOptions == null || productDetails!.choiceOptions!.isEmpty) return -1;

    for(int i=0; i< productDetails!.choiceOptions!.length; i++) {

      if(productDetails!.choiceOptions![i].title == 'Color') {
        return i;
      }

    }

    return -1;
  }

  int getSizeIndex() {

    if(productDetails == null || productDetails!.choiceOptions == null || productDetails!.choiceOptions!.isEmpty) return -1;

    for(int i=0; i< productDetails!.choiceOptions!.length; i++) {

      if(productDetails!.choiceOptions![i].title == 'Size') {
        return i;
      }

    }

    return -1;
  }

  clearFilters() {

    //reset selection in subcategories
    for(int i=0; i<subCategories!.length; i++) {
      subCategories![i].isSelected = false;
    }

    //reset selection in brands
    for(int i=0; i<brandsList!.length; i++) {
      brandsList![i].isSelected = false;
    }

    tags = [];


    for(int i=0; i<attributes!.length; i++) {
      for(int j=0; j<attributes![i].attributeValues!.length; j++) {
        attributes![i].attributeValues![j].isSelected = false;
      }
    }

    notifyListeners();
  }


  addSearchedProducts(List<Products> productsList) {
    products = productsList;
    notifyListeners();
  }

  List<Products> get getSearchedProducts => products!;


  showLoading() {
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    isLoading = false;
    notifyListeners();
  }


}