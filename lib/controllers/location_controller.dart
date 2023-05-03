import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:food_odering_app/modals/response_modals/base_response.dart';
import 'package:food_odering_app/utils/app_constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../base/custom_snackbar.dart';
import '../data/api/api_checker.dart';
import '../data/repositories/location_repo.dart';
import '../modals/address_modal.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  //for service zone==================
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // bool _inZone = false;
  bool _inZone = true;
  bool get inZone => _inZone;
  // bool _btnDisable = true;
  bool _btnDisable = false;
  bool get btnDisable => _btnDisable;
  //----------------------------------
  Future<BaseResponse> getZone(String lat, String long, bool markedLoad) async{
    late BaseResponse _baseResponse;
    if(markedLoad == true){
      _loading = true;
    }else{
      _isLoading = true;
    }
    Response _response = await locationRepo.getZone(lat, long);
    if(_response.statusCode == 200){
      _inZone = true;
      _baseResponse = BaseResponse(true,_response.body['zone_id'].toString());
    }else{
      _inZone = false;
      _baseResponse = BaseResponse(true,_response.statusText.toString());
    }
    if(markedLoad == true){
      _loading = false;
    }else{
      _isLoading = false;
    }
    debugPrint("Zone code : ${_response.statusCode}");
    update();
    return _baseResponse;
  }



  //for service zone==================

  bool _saveAddressLoading = false;
  bool get saveAddressLoading => _saveAddressLoading;

  bool _isLocationLoading = false;
  bool get isLocationLoading => _isLocationLoading;

  bool _loading = false;
  bool get loading => _loading;

  bool _changeAddress = true;
  bool get changeAddress => _changeAddress;

  late Position _position;
  late Position _pickedPosition;

  Position get position => _position;
  Position get pickedPosition => _pickedPosition;

  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;


  Placemark _pickedPlacemark = Placemark();
  Placemark get pickedPlacemark => _pickedPlacemark;

  List<AddressModal> _addressList = [];
  List<AddressModal> get addressList => _addressList;

  late List<AddressModal> _allAddressList;
  List<AddressModal> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ['home','office','others'];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;


  bool _updateAddressData = true;

  late GoogleMapController _googleMapController;
  GoogleMapController get googleMapController => _googleMapController;
  void setMapController (GoogleMapController mapController){
    _googleMapController = mapController;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if(_updateAddressData){
      _loading = true;
      update();
      try{
        if(fromAddress){
          _position = Position(longitude: cameraPosition.target.longitude, latitude: cameraPosition.target.latitude, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
        }else{
          _pickedPosition = Position(longitude: cameraPosition.target.longitude, latitude: cameraPosition.target.latitude, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
        }

        // BaseResponse _baseResponse = await getZone(cameraPosition.target.latitude.toString(), cameraPosition.target.longitude.toString(), false);
        // _btnDisable = _baseResponse.getIsSuccess;

        locationRepo.isLocationInKarachi(cameraPosition.target.latitude, cameraPosition.target.longitude).then((value) {
          if(value){
            _inZone = true;
            _btnDisable = false;
          }else{
            _inZone = false;
            _btnDisable = true;
          }
          update();
        });

      if(_changeAddress){
        //String _address = await getAddressFromGeoCoder(LatLng(cameraPosition.target.latitude, cameraPosition.target.longitude));
        //String address = await locationRepo.getAddress(cameraPosition.target.latitude, cameraPosition.target.longitude);
        //debugPrint(".: ADDRESS %%%%%%%%%%%%:. $address");
      String _address = await locationRepo.getAddress(cameraPosition.target.latitude,cameraPosition.target.longitude);
      fromAddress ? _placemark = Placemark(name: _address) : _pickedPlacemark = Placemark(name: _address);
      }
      }catch(e){
        customSB(title: "Error!",isError: true,e.toString());
      }
    }else{
      _updateAddressData = true;
    }
    _loading = false;
    update();
  }

  Future<String> getAddressFromGeoCoder(LatLng latLng) async {
    String _address = "Unknown location found";
    Response response =  await locationRepo.getAddressFromGeoCoder(latLng);
    debugPrint(".: RESPONSE %%%% : ${response.body}");




    if(response.body['status'] == 'OK'){
      _address =  response.body['results'][0]['formatted_address'].toString();
      debugPrint(".: ADDRESS :. $_address");
    }

    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  AddressModal getUserAddress(){
    late AddressModal _addressModal;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
      _addressModal = AddressModal.fromJson(_getAddress);
    }catch(e){
      customSB(title: "Error!",isError: true,e.toString());
    }
    return _addressModal;
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex = index;
    update();
  }

  Future<BaseResponse> addAddress(AddressModal addressModal) async{
    _saveAddressLoading = true;
   _loading = true;
   update();
   Response response = await locationRepo.addAddress(addressModal);
   BaseResponse baseResponse;
   if(response.statusCode == 200){
     await getAddressList();
     baseResponse = BaseResponse(true, response.body["message"].toString());
     await saveAddress(addressModal);
   }else{
      baseResponse = BaseResponse(false, response.body["message"].toString());
   }
   _loading = false;
   _saveAddressLoading = false;
   update();
   return baseResponse;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAddressList();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address){
        _addressList.add(AddressModal.fromJson(address));
        _allAddressList.add(AddressModal.fromJson(address));
      });
    }else{
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveAddress(AddressModal addressModal) async {
    String userAddress = jsonEncode(addressModal.toJson());
    return await locationRepo.saveAddress(userAddress);
  }

  String getAddressFromStorage(){
    return locationRepo.getUserAddress();
  }

  void setAddAddressData(){
    _position = _pickedPosition;
    _placemark = _pickedPlacemark;
    _updateAddressData = false;
    update();
  }

  //========= Current Location

  bool _currentLocationLoading = false;
  bool get getCurrentLocationLoading => _currentLocationLoading;
  double _currentLat = 0.0;
  double _currentLng = 0.0;
  double get currentLat => _currentLat;
  double get currentLng => _currentLng;

  LocationData? _locationData;
  LocationData? get locationData => _locationData;

  Future<void> getCurrentLocation() async {
    _currentLocationLoading = true;
    await locationRepo.getLocation().then((value) {
      _locationData = value!;
      _currentLat = _locationData!.latitude!;
      _currentLng = _locationData!.longitude!;
      AppConstants.currentLat = _currentLat;
      AppConstants.currentLng = _currentLng;
      debugPrint("LAT : ${AppConstants.currentLat}");
      debugPrint("LAN : ${AppConstants.currentLng}");
    });
    _currentLocationLoading = false;
    update();
  }



  //========= Current Location

  // =============== map suggestions
  List<Prediction> _predictionsList = [];
  Future<List<Prediction>> searchLocation(BuildContext context, String text) async{
    if(text != null && text.isNotEmpty) {
      Response _response = await locationRepo.searchLocation(text);
      if (_response.statusCode == 200 && _response.body['status'] == 'OK') {
        _predictionsList = [];
        _response.body['predictions'].forEach((prediction){
          _predictionsList.add(Prediction.fromJson(prediction));
        });
      }else{
        debugPrint(_response.body.toString());
        debugPrint(_response.body['status'].toString());
        ApiChecker.checkApi(_response);
      }
    }
    return _predictionsList;
  }

  Future<List<String>>  getPlace(String text) async {
    List<String> _places = [
      "4322 Elmwood Avenue, Los Angeles",
      "1120 Maple Street, New York",
      "1731 Main Street, Houston",
      "812 Oak Avenue, Phoenix",
      "2997 Chestnut Street, Chicago",
      "5251 Cedar Lane, Philadelphia",
      "4816 Pine Road, San Antonio",
      "6333 Walnut Avenue, San Diego",
      "2378 Spruce Street, Dallas",
      "1517 Birch Street, San Jose",
      "2602 Pine Street, Austin",
      "1400 Oak Avenue, Jacksonville",
      "2164 Maple Street, Fort Worth",
      "3849 Elmwood Avenue, Columbus",
      "900 Cedar Lane, San Francisco",
      "2512 Pine Road, Charlotte",
      "4492 Chestnut Street, Indianapolis",
      "3715 Spruce Street, Seattle",
      "1296 Walnut Avenue, Denver",
      "3261 Birch Street, Washington",
      "2049 Maple Street, Boston",
      "4653 Pine Road, El Paso",
      "3121 Oak Avenue, Nashville",
      "2787 Cedar Lane, Detroit",
      "1700 Elmwood Avenue, Memphis",
      "2771 Chestnut Street, Portland",
      "3294 Spruce Street, Oklahoma City",
      "4977 Pine Road, Las Vegas",
      "1652 Birch Street, Louisville",
      "1993 Cedar Lane, Baltimore",
      "4025 Maple Street, Milwaukee",
      "4220 Walnut Avenue, Albuquerque",
      "3686 Pine Road, Tucson",
      "1535 Oak Avenue, Fresno",
      "2037 Cedar Lane, Sacramento",
      "2556 Elmwood Avenue, Mesa",
      "3844 Chestnut Street, Atlanta",
      "4282 Pine Road, Kansas City",
      "4659 Spruce Street, Colorado Springs",
      "1970 Birch Street, Miami",
      "4317 Maple Street, Raleigh",
      "3899 Oak Avenue, Omaha",
      "1248 Cedar Lane, Long Beach",
      "3140 Walnut Avenue, Virginia Beach",
      "4450 Pine Road, Oakland",
      "2508 Elmwood Avenue, Minneapolis",
      "1977 Chestnut Street, Tulsa",
      "1746 Spruce Street, Wichita",
      "4129 Birch Street, New Orleans",
      "3896 Cedar Lane, Arlington",
      "4507 Maple Street, Tampa",
      "1405 Oak Avenue, Honolulu",
    ];
    List<String> selectedAddresses = [];

    // Generate a random number between 4 and 5 for the number of addresses to select
    int numAddresses = Random().nextInt(2) + 4;

    // Randomly select addresses from the list
    while (selectedAddresses.length < numAddresses) {
      String randomAddress =
      _places[Random().nextInt(_places.length)];
      if (!selectedAddresses.contains(randomAddress)) {
        selectedAddresses.add(randomAddress);
      }
    }
    if(text != null && text.isNotEmpty) {
      return selectedAddresses;
    }
    return [];
  }

  // =============== map suggestions


}