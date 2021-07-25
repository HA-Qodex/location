
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var myLatitude = 0.0.obs;
  var myLongitude = 0.0.obs;
  var myAddress = "".obs;
  var pointerAddress = "".obs;

  //var markerList = <Marker>[].obs;

  static GoogleMap? googleMap;

  static LatLng defaultLocation = LatLng(23.8103, 90.4125);
  static GoogleMapController? googleMapController;

  onMapCreated(GoogleMapController mapController) {

    googleMapController = mapController;
  }

  onCameraMove(CameraPosition cameraPosition) {
    defaultLocation = cameraPosition.target;
  }

  onCameraIdle() async {
    await getMarkerLocation(
        latitude: defaultLocation.latitude,
        longitude: defaultLocation.longitude);
  }

  @override
  void onInit() {
    getMyLocation();
    //getMarker();
    super.onInit();
  }

  getMyLocation() async {
    //Future.delayed(Duration(seconds: 1));
    GeocodingPlatform geocoder = GeocodingPlatform.instance;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final location = Location(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now());

    myLatitude.value = location.latitude;
    myLongitude.value = location.longitude;

    print(myLatitude.value);
    print(myLongitude.value);

    var address = await geocoder.placemarkFromCoordinates(
        location.latitude, location.longitude);

    myAddress.value = address.first.name! +
        ", " +
        address.first.street! +
        ", " +
        address.first.locality!;
    print(myAddress.value);

    goCurrentLocation();
    //getMarker();
  }

  getMarkerLocation(
      {required double latitude, required double longitude}) async {
    GeocodingPlatform geocoder = GeocodingPlatform.instance;
    final location = Location(
        latitude: latitude, longitude: longitude, timestamp: DateTime.now());

    var address = await geocoder.placemarkFromCoordinates(
        location.latitude, location.longitude);

    pointerAddress.value = address.first.thoroughfare! + ", \n" + address.first.locality!;

    print("Pointer add" + pointerAddress.value);
  }

  goCurrentLocation() {
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(myLatitude.value, myLongitude.value), zoom: 16)));
  }

  // getMarker() {
  //   markerList.add(
  //     Marker(
  //         markerId: MarkerId("myMarker"),
  //         icon: BitmapDescriptor.defaultMarker,
  //         position: LatLng(defaultLocation.latitude, defaultLocation.longitude),
  //         draggable: true),
  //   );
  // }
}
