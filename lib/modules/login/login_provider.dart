// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/layout/home_screen.dart';
import 'package:flutter_technical_task/models/user_profile.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';
import 'package:flutter_technical_task/utils/ar.dart';
import 'package:flutter_technical_task/utils/en.dart';

class LoginProvider extends ChangeNotifier
{
  Icon suffixIcon = const Icon(
    Icons.visibility_outlined,
    color: Colors.pink,
  );
  bool obscure = true;

  void changeVisibilityOfEye() {
    obscure = !obscure;
    if (obscure) {
      suffixIcon = const Icon(
        Icons.remove_red_eye,
        color: Colors.pink,
      );
    } else {
      suffixIcon = const Icon(
        Icons.visibility_off_outlined,
        color: Colors.pink,
      );
    }
    notifyListeners();
  }

  String logInMaterialButton =SharedHelper.get(key: 'lang')=='en'?en['LogIn']!:ar['LogIn']!;
  String logInTextButton = SharedHelper.get(key: 'lang')=='en'?en['CreateNewAccount']!:ar['CreateNewAccount']!;

  void logInToggle() {
    if (logInMaterialButton == (SharedHelper.get(key: 'lang')=='en'?en['LogIn']!:ar['LogIn']!)) {
      logInMaterialButton =SharedHelper.get(key: 'lang')=='en'?en['Sign Up']!:ar['Sign Up']!;
      logInTextButton =SharedHelper.get(key: 'lang')=='en'?en['I Already Have An Account']!:ar['I Already Have An Account']! ;
    } else {
      logInMaterialButton = SharedHelper.get(key: 'lang')=='en'?en['LogIn']!:ar['LogIn']!;
      logInTextButton = SharedHelper.get(key: 'lang')=='en'?en['CreateNewAccount']!:ar['CreateNewAccount']!;
    }
    notifyListeners();
  }
  bool LoginLoadingStates=false;
  void LogIn({
    required String email,
    required String password,
    required context,
  }) {
    LoginLoadingStates=true;
    notifyListeners();
    print(email);
    print(password);
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      SharedHelper.save(value: value.user!.uid.toString(), key: 'uid');
      SharedHelper.save(value:true, key: 'signIn');
      LoginLoadingStates=false;
      navigateToWithoutReturn(context,HomeScreen());
      notifyListeners();
    }).catchError((onError){
      print(onError);
      showToast(message: onError.toString(), state: ToastState.ERROR);
      LoginLoadingStates=false;
      notifyListeners();
    });
  }
  UserProfile? userProfile;
  void signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userName,
    required String phone,
    required context,
  }) {
    showToast(message: 'Create Account Loading ....', state: ToastState.WARNING);
    LoginLoadingStates=true;
    notifyListeners();
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) async {
      userProfile =UserProfile(Address(
        city: 'marg',
        geolocation: Geolocation(
          lat: 18.5,
          long: 19.2,
        ),
        number: 55,
        street: 'mmm',
        zipcode: '12926-3874',
      ), email, Name(
        firstname: firstName,
        lastname: lastName,
      ), password, phone, userName,null);
      storeDatabaseFirestore(value.user!.uid.toString()).then((value) {
        LoginLoadingStates=false;
        SharedHelper.save(value:true, key: 'signIn');
        navigateToWithReturn(context, HomeScreen());
        notifyListeners();
      }).catchError((onError) {
        LoginLoadingStates=false;
        showToast(message: onError.toString(), state: ToastState.ERROR);
        notifyListeners();
      });
    }).catchError((onError) {
      LoginLoadingStates=false;
      notifyListeners();
    });
  }

  Future storeDatabaseFirestore(String id) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userProfile!.toJson());
  }
}