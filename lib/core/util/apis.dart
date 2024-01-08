
/*
*  Date 3 - Nov-2023
*  Author: Raheel Khan- Abaska Technologies
*  Description: APIs endpoints constants
*/

class APIs {

  static String token = '';

  static const String baseURL = 'https://labees.boedelipos.ch/api/v1/';
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String mainCategories = 'categories';
  static const String dashboardData = 'dashboard-data';
  static const String productListing = 'categories/products/';
  static const String productDetails = 'products/details/';
  static const String shippingMethods = 'products/shipping-methods';
  static const String checkoutSettings = 'config/checkout-settings';
  static const String applyCoupon = 'coupon/apply';
  static const String countriesList = 'config/countries-list';
  static const String citiesList = 'config/cities-list/';
  static const String addAddress = 'customer/address/add';
  static const String allAddresses = 'customer/address/all';
  static const String placeOrder = 'customer/order/mobile-place';
  static const String updateProfile = 'customer/update-profile';
  static const String getUerInfo = 'customer/info';
  static const String deleteAddress = 'customer/address';
  static const String updateAddress = 'customer/address/update';
  static const String getOrders = 'customer/order/list';
  static const String cancelOrders = 'order/cancel-order';
  static const String newsletter = 'add-subscription';
  static const String sellerRegister = 'seller/register';
  static const String contactUs = 'contact-store';
  static const String companySettings = 'config/company-settings';
  static const String addToWishlist = 'customer/wish-list/add';
  static const String removeFromWishlist = 'customer/wish-list/remove';
  static const String getWishlist = 'customer/wish-list';
  static const String walletList = 'customer/wallet/list';
  static const String myPoints = 'customer/loyalty/list';
  static const String accountSettings = 'config/account-settings';
  static const String convertToCurrency = 'customer/loyalty/loyalty-exchange-currency';
  static const String forgotPassword = 'auth/forgot-password';
  static const String verifyOTP = 'auth/verify-otp';
  static const String resetPassword = 'auth/reset-password';
  static const String addReview = 'products/reviews/submit';



  //images
  static const String imageBaseURL = 'https://labees.boedelipos.ch/storage/app/public/';
  static const String categoryImages = 'category/';
  static const String bannerImages = 'banner/';
  static const String productThumbnailImages = 'product/thumbnail/';
  static const String productImages = 'product/';
  static const String brandImages = 'brand/';
  static const String attributeValue = 'attribute_value/';


}