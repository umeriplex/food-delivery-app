import 'package:food_odering_app/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modals/request_modals/sign_up.dart';
import '../../utils/app_constants.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registerUser (SignUpBody body) async {
     return await apiClient.postData(AppConstants.registerUrl,body.toJson());
  }

  saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

}