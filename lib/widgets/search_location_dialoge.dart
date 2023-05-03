import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import '../controllers/location_controller.dart';
import '../utils/colors.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationDialogue({Key? key, this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimentions.width20,vertical: Dimentions.height20),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimentions.radius20/2),
        ),
        child: SizedBox(
          width: Dimentions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              autofocus: true,
              autocorrect: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,

              decoration: InputDecoration(
                hintText: "Search Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimentions.radius20/2),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimentions.width20,vertical: Dimentions.height20),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            suggestionsCallback: (String pattern) async {
              return await Get.find<LocationController>().getPlace(pattern);
              //return await Get.find<LocationController>().searchLocation(context, pattern);
            },
            itemBuilder: (BuildContext context, address) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimentions.radius20/2),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,color: AppColors.mainColor,),
                      Expanded(child: Text(address.toString())),
                    ],
                  ),
                ),
              );
            },
            onSuggestionSelected: (Object? suggestion) {  },
          ),
        ),
      ),
    );
  }
}
