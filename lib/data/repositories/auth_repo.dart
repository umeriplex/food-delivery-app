import 'package:flutter/cupertino.dart';
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

  Future<Response> login (String email, String password) async {
    return await apiClient.postData(AppConstants.logInUrl,{"phone":email,"password":password});
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token) ?? false;
  }

  bool clearData(){
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.PHONE);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<void> saveUserNumberPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}