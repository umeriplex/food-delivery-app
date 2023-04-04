class AppConstants{
  // TODO ...........:::::::::::: APP NAME AND VERSION :::::::::::.............
  static const String appName = "Food Buddy";
  static const int version = 1;

  // TODO ...........:::::::::::: API URLS :::::::::::.............
  /*"http://mvs.bslmeiyu.com"*/
  // http://127.0.0.1:8000
  // http://127.0.0.1:8000/admin/foods/**/
  static const String baseUrl ="http://mvs.bslmeiyu.com";
  static const String imagesUrl = "$baseUrl/uploads/";
  static const String popularProductsUrl = "/api/v1/products/popular";
  // static const String popularProductsUrl = "/api/v1/products/drinks";
  static const String recommendedProductsUrl = "/api/v1/products/recommended";
  static const String drinksUrl = "/api/v1/products/drinks";
  static const String registerUrl = "/api/v1/auth/register";

  // TODO ...........:::::::::::: API TOKEN :::::::::::.............
  static const String token = "someToken";


  // TODO ...........:::::::::::: INTERNET IMAGES :::::::::::.............
  static const String foodPlaceHolder = "https://theme-assets.getbento.com/sensei/c473521.sensei/assets/images/catering-item-placeholder-704x520.png";

  // TODO ...........:::::::::::: CART LIST :::::::::::.............
  static const String CART_LIST = "cart_list";
  static const String CART_HISTORY = "cart_history";

}