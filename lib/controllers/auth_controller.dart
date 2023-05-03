import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/repositories/auth_repo.dart';
import '../modals/request_modals/sign_up.dart';
import '../modals/response_modals/base_response.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<BaseResponse> registration(SignUpBody body) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registerUser(body);
    late BaseResponse baseResponse;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      baseResponse = BaseResponse(true, "You've been registered successfully");
    }else{
      debugPrint("ERROR ==> ${response.statusText}");
      baseResponse = BaseResponse(false, response.statusText.toString());
    }
    _isLoading = false;
    update();
    return baseResponse;
  }


  Future<BaseResponse> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late BaseResponse baseResponse;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      baseResponse = BaseResponse(true, "You've been Logged in successfully");
    }else{
      debugPrint("ERROR ==> ${response.statusText}");
      baseResponse = BaseResponse(false, response.statusText.toString());
    }
    _isLoading = false;
    update();
    return baseResponse;
  }

  void saveUserData(String number, String password) async {
    authRepo.saveUserNumberPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearData(){
    return authRepo.clearData();
  }






}