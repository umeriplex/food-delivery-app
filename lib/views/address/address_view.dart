import 'package:flutter/material.dart';
import 'package:food_odering_app/controllers/auth_controller.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/views/address/picked_address_view.dart';
import 'package:food_odering_app/widgets/texts.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../base/custom_snackbar.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../modals/address_modal.dart';
import '../../utils/app_constants.dart';
import '../../widgets/AuthTextFields.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonNameController = TextEditingController();
  TextEditingController _contactPersonNumberController = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =  CameraPosition(target: LatLng(AppConstants.currentLat, AppConstants.currentLng), zoom: 17);
  late LatLng _initPosition =  LatLng(AppConstants.currentLat,AppConstants.currentLng);
  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();

    if (_isLogged && Get.find<UserController>().userModal == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {

      if(Get.find<LocationController>().getAddressFromStorage() == ''){
        Get.find<LocationController>().saveAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]), double.parse(Get.find<LocationController>().getAddress["longitude"])),
          zoom: 17);
      _initPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(
          text: 'Address Section',
          size: Dimentions.font20,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GetBuilder<UserController>(
          builder: (userController) {
            if (userController.userModal != null) {
              _contactPersonNameController.text = userController.userModal!.name;
              _contactPersonNumberController.text = userController.userModal!.phone;
              if(Get.find<LocationController>().addressList.isNotEmpty){
                _addressController.text = Get.find<LocationController>().getUserAddress().address;
              }
            }
            return GetBuilder<LocationController> (
              builder: (lController) {
                _addressController.text = lController.placemark.name ?? '';
                debugPrint("NAME : ${lController.placemark.name ?? ''}");
                debugPrint("ADDRESS CONTROLLER : ${_addressController.text.toString() ?? ''}");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: Dimentions.width20, right: Dimentions.width20,top:Dimentions.height20),
                      height: (Dimentions.height30 * 4) + 20,
                      width: Dimentions.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.radius15 - 10),
                        border: Border.all(width: Dimentions.width10 - 8,color: AppColors.mainColor)
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(target: _initPosition, zoom: 17),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            // called this function right after when map moving gets stop
                            onCameraIdle: (){lController.updatePosition(_cameraPosition, true);},
                            onCameraMove: ((position) => _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller){lController.setMapController(controller);},
                            onTap: (latlng){
                              debugPrint("TAP");
                              Get.toNamed(RouteHelper.getPickedAddressView(),arguments: PickedAddressView(
                                fromaddress: true,
                                fromsignUp: false,
                                mapController: lController.googleMapController,
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                    Dimentions.height10.ph,
                    SizedBox(
                      height: Dimentions.height45 + 10,
                      child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: lController.addressTypeList.length,itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){lController.setAddressTypeIndex(index);},
                          child: Container(
                            padding: EdgeInsets.only(left:Dimentions.width30 - 10, right:Dimentions.width30 - 10),
                            margin: EdgeInsets.only(left: Dimentions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.grey[200]!,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),],
                              borderRadius: BorderRadius.circular(Dimentions.radius15 - 10),
                            ),
                            child: Center(child: Icon(
                                index == 0 ? Icons.home_rounded : index == 1 ? Icons.work_rounded : Icons.location_on,
                              color: lController.addressTypeIndex == index ? AppColors.mainColor : AppColors.signColor,
                            ),),
                          ),
                        );
                      }),
                    ),
                    Dimentions.height10.ph,
                    AuthTextFields(hintText: "Your address", prefixIcon: Icons.location_city_rounded, controller: _addressController,),
                    AuthTextFields(hintText: "Your Name", prefixIcon: Icons.person_outline_rounded, controller: _contactPersonNameController,),
                    AuthTextFields(hintText: "Your Phone", prefixIcon: Icons.phone, controller: _contactPersonNumberController,),

                  ],
                );
              }
            );
          }
        ),
      ),
        bottomNavigationBar: GetBuilder<LocationController>(
            builder: (lController) {
              return Container(
                height: Dimentions.height45 + 20,
                width: Dimentions.screenWidth,
                margin: EdgeInsets.only(left: Dimentions.width20, right: Dimentions.width20, bottom: Dimentions.height20),
                child: lController.saveAddressLoading == false ? ElevatedButton(
                  onPressed: () {
                    AddressModal addressModal = AddressModal(
                      address: _addressController.text.toString(),
                      addressType: lController.addressTypeList[lController.addressTypeIndex],
                      contactPersonNumber: _contactPersonNumberController.text.toString(),
                      contactPersonUserName: _contactPersonNameController.text.toString(),
                      lati: lController.position.latitude.toString() ?? "",
                      longi: lController.position.longitude.toString() ?? "",
                    );
                    lController.addAddress(addressModal).then((value){
                      if(value.getIsSuccess){
                        Get.back();
                        customSB(title: "Success!",isError: false, "Address added successfully");
                      }else{
                        customSB(title: "Error!",isError: true, value.getMessage);
                      }
                    }).onError((error, stackTrace){
                      customSB(title: "Error!",isError: true, error.toString());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimentions.radius15),
                    ),
                  ),
                  child: BigText(
                    text: 'Save Address',
                    size: Dimentions.font20,
                    color: AppColors.white,
                  ),
                ) : const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),),
              );
            }
        )
    );
  }
}
