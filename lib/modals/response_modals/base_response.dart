class BaseResponse{
  bool _isSuccess;
  String _message;
  BaseResponse(this._isSuccess, this._message);

  String get getMessage => _message;
  bool get getIsSuccess => _isSuccess;
}