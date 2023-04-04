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
    debugPrint("Sign Up 8");
    _isLoading = true;
    Response response = await authRepo.registerUser(body);
    debugPrint("Sign Up 9");
    late BaseResponse baseResponse;
    if(response.statusCode==200){
      debugPrint("Sign Up 10");
      authRepo.saveUserToken(response.body["token"]);
      baseResponse = BaseResponse(true, "You've been registered successfully");
    }else{
      baseResponse = BaseResponse(false, response.statusText.toString());
    }
    _isLoading = false;
    update();
    return baseResponse;
  }


}