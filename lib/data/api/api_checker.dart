import 'package:food_odering_app/base/custom_snackbar.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode == 401){
      Get.offNamed(RouteHelper.getSignInView());
    }
    else{
    customSB(response.statusText.toString(),isError: false,title: ' Status code : ${response.statusCode.toString()}');
    }

  }
}