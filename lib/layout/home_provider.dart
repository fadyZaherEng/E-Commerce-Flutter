// ignore_for_file: avoid_print, non_constant_identifier_names


import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/models/cart_model.dart';
import 'package:flutter_technical_task/models/products_model.dart';
import 'package:flutter_technical_task/models/user_profile.dart';
import 'package:flutter_technical_task/modules/home/home.dart';
import 'package:flutter_technical_task/modules/profile/setting_screen.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';
import 'package:flutter_technical_task/shared/network/remote/dio_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_technical_task/utils/ar.dart';
import 'package:flutter_technical_task/utils/en.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
class HomeProvider with ChangeNotifier{
  int currentIndex = 0;

  List<Widget> listScreen = [
    InterHomeScreen(),
    SettingsScreen(),
  ];

 void changeNav(index){
   currentIndex=index;
   notifyListeners();
 }
 List<String?>categories=[];
 dynamic selectedCat;
 void changeCat(String cat){
   selectedCat=cat;
   notifyListeners();
 }
 Future<void> getCategories()
 async{
   categories=[];
  await DioHelper.getData(url: 'products').then((value) {
     ModelProducts modelProducts=ModelProducts.fromjson(value.data);
     selectedCat=modelProducts.products[0].category;
     for(var val in modelProducts.products)
       {
         if(!categories.contains(val.category)) {
           categories.add(val.category);
         }
       }
     print(categories[1]);
   }).catchError((onError){
     print(onError.toString());
   });
   notifyListeners();
 }
 List<ProductsModel>productsBasedCategories=[];
 Future<List<ProductsModel>> getProducts(String cat)
 async{
    productsBasedCategories=[];
    await  DioHelper.getData(url: 'products').then((value) {
      ModelProducts modelProducts=ModelProducts.fromjson(value.data);
      productsBasedCategories=[];
      for(var val in modelProducts.products)
      {
        if(val.category==cat) {
          productsBasedCategories.add(val);
          print(val.title);
        }
      }
    }).catchError((onError){
      print(onError.toString());
    });
    return productsBasedCategories;
    notifyListeners();
  }
 //change lang
  dynamic myLang=SharedHelper.get(key: 'lang');

void changeLanguage(String lang)
async{
  myLang=lang;
  Get.updateLocale(Locale(lang));
  SharedHelper.save(value: lang, key: 'lang');
  notifyListeners();
}
//current user
  UserProfile? userProfile;

  void getUserProfile() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .snapshots()
        .listen((event) {
         userProfile = UserProfile.fromJson(event.data());
        // notifyListeners();
    }).onError((handleError) {
     print(handleError.toString());
     notifyListeners();
    });
  }
  dynamic mode;
  void modeChange(context) {
    if (SharedHelper.get(key: 'theme') == 'Light Theme') {
      SharedHelper.save(value: 'Dark Theme', key: 'theme');
      mode='dark';
    }
    else {
      mode='light';
      SharedHelper.save(value: 'Light Theme', key: 'theme');
    }
    Phoenix.rebirth(context);
    notifyListeners();

  }

  void changeSettings(context) {
    Navigator.pop(context);
    changeNav(1);
  }
  //profile
   void navigte(context)
   {
     Navigator.of(context);
     notifyListeners();
   }
//location permission
  final Location location = Location();

  PermissionStatus? _permissionGranted;

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
    await location.hasPermission();
      _permissionGranted = permissionGrantedResult;
    notifyListeners();
  }
  Future<void> requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
      await location.requestPermission();
      _permissionGranted = permissionRequestedResult;
      notifyListeners();
    }
  }
 //address

  Marker? origin;
  Circle? circle;
  GoogleMapController? googleMapController;

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(52.2165157, 6.9437819),
    zoom: 14.4746,
  );

  void onMapCreated(GoogleMapController MapController) {
    googleMapController = MapController;
  }
  LocationData? currLocation;
  Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load('assets/images/marker.png');
    return byteData.buffer.asUint8List();
  }
  Future<void> getCurrentLocation() async {
      Uint8List imageData = await getMarker();
      currLocation = await Location().getLocation();
      LatLng latLng = LatLng(
          currLocation!.latitude as double,currLocation!.longitude as double);
      cameraPosition= CameraPosition(target: latLng, zoom: 18);
      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 18),
          ));
     await updateCurrentLocation(imageData, currLocation!);
     notifyListeners();

  }
  Future<void> updateCurrentLocation(Uint8List imageData, LocationData location) async{
    LatLng latLng =
    LatLng(location.latitude as double, location.longitude as double);
    origin = Marker(
      markerId: const MarkerId('me'),
      position: latLng,
      icon: BitmapDescriptor.fromBytes(imageData),
      flat: true,
      draggable: false,
      zIndex: 2,
      rotation: location.heading as double,
    );
    circle = Circle(
      circleId: const CircleId('car'),
      center: latLng,
      radius: location.accuracy as double,
      strokeColor: Colors.black,
      strokeWidth: 2,
      zIndex: 1,
      fillColor: Colors.purple.withAlpha(60),
    );
    notifyListeners();
  }
  //user edit user data
  void editUser()
  async{
    print(userProfile);
    FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
    .set(userProfile!.toJson())
    .then((value){
      showToast(message:'Edited Successfully', state: ToastState.SUCCESS);
      notifyListeners();
    }).catchError((onError){
      print(onError.toString());
      showToast(message: onError.toString(), state: ToastState.ERROR);
      notifyListeners();
    });
  }
 //cart
 void addToCart(CartModel cartModel,int productId,bool edit)
  async{
    FirebaseFirestore.instance
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection(productId.toString())
        .doc('myCarts')
        .set(cartModel.toJson())
        .then((value){
          if(!edit) {
            showToast(message: 'Added Successfully', state: ToastState.SUCCESS);
          }
          else{
            showToast(message: 'Edited Successfully', state: ToastState.SUCCESS);
          }
      notifyListeners();
    }).catchError((onError){
      printError(info: onError.toString());
      showToast(message: onError.toString(), state: ToastState.ERROR);
      notifyListeners();
    });
  }


}