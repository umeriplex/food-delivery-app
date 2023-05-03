import 'package:flutter/cupertino.dart';
import 'package:food_odering_app/data/api/api_client.dart';
import 'package:food_odering_app/utils/app_constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../modals/address_modal.dart';

class LocationRepo {
  ApiClient apiClient;
  final SharedPreferences prefs;
  LocationRepo({required this.apiClient, required this.prefs});

  Future<Response> getAddressFromGeoCoder(LatLng latLng) async{
    return await apiClient.getData(
        '${AppConstants.geoCodeUrl}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }

  Future<String> getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
    Placemark place = placemarks[0];
    return "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
  }

  String getUserAddress (){
    return prefs.getString(AppConstants.userAddress) ?? '';
  }

  Future<Response> addAddress(AddressModal addressModal){
    return apiClient.postData(AppConstants.addUserAddressUrl, addressModal.toJson());
  }

  Future<Response> getAddressList() async{
    return await apiClient.getData(AppConstants.addressListUrl);
  }

  Future<bool> saveAddress(String userAddress) async {
    apiClient.updateHeader(prefs.getString(AppConstants.token) ?? '');
    debugPrint("Address Saved");
    return await prefs.setString(AppConstants.userAddress, userAddress);
  }
  Future<Response> getZone(String lat, String lang) async{
    return await apiClient.getData('${AppConstants.addressZoneUrl}?lat=$lat&lng=$lang');
  }

  final karachiBounds = {
    "north": 25.147507,
    "south": 24.707219,
    "west": 66.710858,
    "east": 67.352456,
  };

  Future<bool> isLocationInKarachi(double latitude, double longitude) async{
    return (latitude >= karachiBounds["south"]! &&
        latitude <= karachiBounds["north"]! &&
        longitude >= karachiBounds["west"]! &&
        longitude <= karachiBounds["east"]!);
  }

  Future<loc.LocationData?> getLocation() async {
    loc.Location location = loc.Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }


  Future<Response> searchLocation(String text) async{
    return await apiClient.getData('${AppConstants.searchLocationUrl}?search-text=$text');
  }


  /*Future<List<dynamic>> getPlaces(String query) async {
    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=AIzaSyB9prhqs6cUbNaO0xowCq4axC-C5FaUPzQ";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      debugPrint(data.toString());
      return data["results"];
    } else {
      throw Exception("Failed to load places");
    }
  }*/

}