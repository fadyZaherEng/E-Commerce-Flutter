// ignore_for_file: must_be_immutable, avoid_print

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/layout/home_provider.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class AddressScreen extends StatefulWidget {
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  LatLng? latLng;
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context,listen: false).getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    var obj=Provider.of<HomeProvider>(context,listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Google Maps',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: obj.cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController googleMapController) {
          Provider.of<HomeProvider>(context,listen: false).onMapCreated(googleMapController);
        },
        markers: Set.of(
            obj.origin != null ? [obj.origin as Marker] : [
            ]),
        circles: Set.of(
            obj.circle != null ? [obj.circle as Circle] : [
            ]),
        onTap: (value){
            editUserAddress(value, context);
            print(obj.userProfile!.address!.geolocation!.lat);
            print(obj.userProfile!.address!.geolocation!.long);
            showToast(message: 'تم حفظ هذا المكان للتوصيل', state: ToastState.SUCCESS);
        },
        //polylines: controller.polylines,
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () async {
               showToast(message: 'تم حفظ مكانك الحالي للتوصيل', state: ToastState.SUCCESS);
               Provider.of<HomeProvider>(context,listen: false).getCurrentLocation();
               latLng=LatLng(obj.currLocation!.latitude as double, obj.currLocation!.longitude as double);
               editUserAddress(latLng!, context);
               print(obj.userProfile!.address!.geolocation!.lat);
               print(obj.userProfile!.address!.geolocation!.long);
            },
            child: const Icon(CupertinoIcons.location),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  //adddress
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
  }
  void editUserAddress(LatLng latLng,context)async{
    var obj= Provider.of<HomeProvider>(context, listen: false);
    obj.userProfile!.address!.geolocation!.lat=latLng.latitude;
    obj.userProfile!.address!.geolocation!.long=latLng.longitude;
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude,latLng.longitude);
   // print(placemarks);
    Placemark place = placemarks[0];
    obj.userProfile!.address!.street=place.street;
    obj.userProfile!.address!.city=place.locality;
    obj.userProfile!.address!.number=place.postalCode;
    obj.userProfile!.address!.zipcode=place.isoCountryCode;
  }

}
