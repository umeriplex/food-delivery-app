import 'package:flutter/material.dart';
import 'package:food_odering_app/controllers/location_controller.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/search_location_dialoge.dart';

class PickedAddressView extends StatefulWidget {
  final bool fromsignUp;
  final bool fromaddress;
  final GoogleMapController? mapController;

  const PickedAddressView({Key? key, required this.fromsignUp, required this.fromaddress, this.mapController}) : super(key: key);

  @override
  State<PickedAddressView> createState() => _PickedAddressViewState();
}

class _PickedAddressViewState extends State<PickedAddressView> {

  late CameraPosition _cameraPosition;
  late GoogleMapController _googleMapController;
  late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = LatLng(AppConstants.currentLat, AppConstants.currentLng);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    }
    else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]), double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (lController) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(target: _initialPosition,zoom: 17),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition position){
                        _cameraPosition = position;
                      },
                      onMapCreated: (GoogleMapController mapController){
                        _googleMapController = mapController;
                      },
                      onCameraIdle: (){
                        Get.find<LocationController>().updatePosition(_cameraPosition,false);
                      },

                    ),
                    Center(
                      child: !lController.loading ? Image.asset("assets/image/pick_marker.png",height: 50,width: 50,) : const CircularProgressIndicator(color: AppColors.mainColor,),
                    ),
                    Positioned(
                      top: Dimentions.height45,
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      child: InkWell(
                        onTap: (){
                         Get.dialog(LocationDialogue(mapController: _googleMapController,));
                        },
                        child: Container(
                          height: Dimentions.height45+10,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(Dimentions.radius20/2),
                            boxShadow: [BoxShadow(
                                color: AppColors.mainColor.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on,color: AppColors.priceColor,size: Dimentions.icon24+4,),
                                Expanded(
                                  child: Text(
                                    lController.pickedPlacemark.name ?? "Unnamed Location",
                                    style: TextStyle(
                                      color: AppColors.black87,
                                      fontSize: Dimentions.font16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(Icons.search_rounded,color: AppColors.white,size: Dimentions.icon24+4,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*Positioned(
                      bottom: Dimentions.height20*5,
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      child: lController.isLoading == true ? const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),) : CustomButton(
                        text: lController.inZone ? widget.fromaddress ? "Pick Address" : "Pick Location" : "Service is not available in your area",
                        onPressed: (!lController.btnDisable || lController.loading) ? null : (){
                          debugPrint("1");
                          if(lController.pickedPosition.latitude != 0 && lController.pickedPlacemark.name != null){
                            debugPrint("2");
                            if(widget.fromaddress){
                              debugPrint("3");
                              if(widget.mapController != null){
                                widget.mapController!.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                              lController.pickedPosition.latitude,
                                              lController.pickedPosition.longitude,
                                            ),
                                            zoom: 17
                                        )
                                    )
                                );
                                lController.setAddAddressData();
                              }
                              Get.back();
                              //Get.toNamed(RouteHelper.getAddressView());
                            }
                          }
                        },
                      ),
                    ),*/
                    Positioned(
                      bottom: Dimentions.height20*5,
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      child: lController.loading == true ? const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),) : CustomButton(
                        text: lController.inZone ? (widget.fromaddress ? "Pick Address" : "Pick Location") : "Service is not available in your area",
                        onPressed: (lController.btnDisable == true) ? null : (){
                          if(lController.pickedPosition.latitude != 0 && lController.pickedPlacemark.name != null){
                            if(widget.fromaddress){

                              if(widget.mapController != null){
                                widget.mapController!.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                              lController.pickedPosition.latitude,
                                              lController.pickedPosition.longitude,
                                            ),
                                            zoom: 17
                                        )
                                    )
                                );
                                lController.setAddAddressData();
                              }
                              Get.back();
                              //Get.toNamed(RouteHelper.getAddressView());
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
