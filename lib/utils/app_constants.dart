class AppConstants{
  // TODO ...........:::::::::::: APP NAME AND VERSION :::::::::::.............
  static const String appName = "Food Buddy";
  static const int version = 1;

  // TODO ...........:::::::::::: API URLS :::::::::::.............
  /*"http://mvs.bslmeiyu.com"*/
  // http://127.0.0.1:8000
  // http://127.0.0.1:8000/admin/foods/**/
  static const String baseUrl ="http://192.168.1.108:4000";
  static const String imagesUrl = "$baseUrl/uploads/";
  //static const String popularProductsUrl = "/api/v1/products/popular";
  static const String popularProductsUrl = "/api/v1/products/popular";
  static const String recommendedProductsUrl = "/api/v1/products/recommended";
  static const String drinksUrl = "/api/v1/products/drinks";
  static const String registerUrl = "/api/v1/auth/register";
  static const String logInUrl = "/api/v1/auth/login";
  static const String userInfoUrl = "/api/v1/customer/info";
  static const String addUserAddressUrl = "/api/v1/customer/address/add";
  static const String addressListUrl = "/api/v1/customer/address/list";
  static const String addressZoneUrl = "/api/v1/config/get-zone-id";
  static const String searchLocationUrl = "/api/v1/config/place-api-autocomplete";

  // TODO ...........:::::::::::: API TOKEN :::::::::::.............
  static const String token = "";


  // TODO ...........:::::::::::: INTERNET IMAGES :::::::::::.............
  static const String foodPlaceHolder = "https://theme-assets.getbento.com/sensei/c473521.sensei/assets/images/catering-item-placeholder-704x520.png";

  // TODO ...........:::::::::::: CART LIST :::::::::::.............
  static const String CART_LIST = "cart_list";
  static const String CART_HISTORY = "cart_history";

  // TODO ...........:::::::::::: USER DATA :::::::::::.............

  static const String PHONE = "phone";
  static const String PASSWORD = "password";


  // TODO ...........:::::::::::: GEO CODE URL :::::::::::.............

  static const String geoCodeUrl = "/api/v1/config/geocode-api";
  static const String userAddress = "user_address";

  static double currentLat = 24.8951267;
  static double currentLng = 45.1452267;
}