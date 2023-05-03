import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../data/repositories/auth_repo.dart';
import '../data/repositories/user_repo.dart';
import '../modals/request_modals/sign_up.dart';
import '../modals/response_modals/base_response.dart';
import '../modals/response_modals/user_modal.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  UserModal? _userModal;
  UserModal? get userModal => _userModal;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<BaseResponse> getUserInfo() async {
    _isLoading = true;
    Response response = await userRepo.getUserInfo();
    late BaseResponse baseResponse;
    if(response.statusCode==200){
      _userModal = UserModal.fromJson(response.body);
      baseResponse = BaseResponse(true, "Success");
    }else{
      baseResponse = BaseResponse(false, response.statusText.toString());
    }
    _isLoading = false;
    update();
    return baseResponse;
  }


  // Future<BaseResponse> login(String email, String password) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await authRepo.login(email, password);
  //   late BaseResponse baseResponse;
  //   if(response.statusCode==200){
  //     authRepo.saveUserToken(response.body["token"]);
  //     baseResponse = BaseResponse(true, "You've been Logged in successfully");
  //   }else{
  //     debugPrint("ERROR ==> ${response.statusText}");
  //     baseResponse = BaseResponse(false, response.statusText.toString());
  //   }
  //   _isLoading = false;
  //   update();
  //   return baseResponse;
  // }
  //
  // void saveUserData(String number, String password) async {
  //   authRepo.saveUserNumberPassword(number, password);
  // }
  //
  // bool userLoggedIn() {
  //   return authRepo.userLoggedIn();
  // }
  //
  // bool clearData(){
  //   return authRepo.clearData();
  // }






}