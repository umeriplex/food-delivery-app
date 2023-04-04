import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../utils/app_constants.dart';
class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String,String> _mainHeaders;
  ApiClient({required this.appBaseUrl}){
   baseUrl = appBaseUrl;
   timeout = const Duration(seconds: 30);
   token = AppConstants.token;
   _mainHeaders = {
     'Content-Type': 'application/json; charset=UTF-8',
     'Authorization': 'Bearer $token',
   };
  }


  // TODO GET REQUEST
  Future<Response> getData(String uri) async{
    try{
      debugPrint("URL ==> : {$baseUrl$uri}");
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 1, body: e.toString());
    }
  }

  // TODO POST REQUEST
  Future<Response> postData(String uri, dynamic body) async{
    try{
      debugPrint("URL ==> : {$baseUrl$uri}");
      debugPrint("BODY ==> : $body");
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