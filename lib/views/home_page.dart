import 'package:fltr_location/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final locationController = Get.put(LocationController());
  final LatLng defaultLocation = LatLng(23.8103, 90.4125);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        child: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: defaultLocation, zoom: 16),
                compassEnabled: true,
                buildingsEnabled: true,
                indoorViewEnabled: true,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                //myLocationEnabled: true,
                zoomControlsEnabled: false,
                trafficEnabled: true,
                //markers: Set.from(locationController.markerList),
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                onMapCreated: locationController.onMapCreated,
                onCameraMove: locationController.onCameraMove,
                onCameraIdle: () {
                  locationController.onCameraIdle();
                },
              ),
              Positioned(
                  top: 50,
                  right: 20,
                  left: 20,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 2,
                              offset: Offset(3, 3))
                        ]),
                    child: TextField(
                      style: GoogleFonts.lato(color: Colors.black, fontSize: 18),
                      cursorColor: Colors.grey[600],
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search_rounded),
                            color: Colors.grey[600],
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          filled: true,
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          hintText: "Search Location",
                          //locationController.pointerAddress.value,
                          hintStyle:
                              GoogleFonts.lato(color: Colors.grey[400], fontSize: 18)),
                      onChanged: (textValue) {
                        //searchAddress = textValue;
                      },
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Center(
                    child: Image.asset(
                  "assets/marker.png",
                  height: 40,
                  width: 40,
                )),
              ),
              Positioned(
                bottom: 0,
                child: GetX<LocationController>(builder: (controller) {
                  return Container(
                    width: width,
                    height: height * 0.1,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: AssetImage("assets/map.png"),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${controller.pointerAddress}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}