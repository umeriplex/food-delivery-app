import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String,String> _mainHeaders;
  late SharedPreferences _sharedPreferences;
  ApiClient({required this.appBaseUrl, required SharedPreferences sharedPreferences}){
   baseUrl = appBaseUrl;
   timeout = const Duration(seconds: 30);
   token = sharedPreferences.getString(AppConstants.token)??"";
   _mainHeaders = {
     'Content-Type': 'application/json; charset=UTF-8',
     'Authorization': 'Bearer $token',
   };
  }


  // TODO GET REQUEST
  Future<Response> getData(String uri, {Map<String, String>? header}) async{
    try{
      debugPrint("GET URL ==> : {$baseUrl$uri}");
      Response response = await get(uri,headers: header??_mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 1, body: e.toString());
    }
  }

  // TODO POST REQUEST
  Future<Response> postData(String uri, dynamic body) async{
    try{
      debugPrint("POST URL ==> : {$baseUrl$uri}");
      debugPrint("POST BODY ==> : $body");
      Response response = await post(uri, body, headers: _mainHeaders);
      debugPrint("RESPONSE ==> : ${response.statusCode}");
      return response;
    }catch(e){
      return Response(statusCode: 1, body: e.toString());
    }
  }

  // TODO UPDATE HEADER
  void updateHeader(String token){
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

}