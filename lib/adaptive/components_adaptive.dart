// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

//Indicator
Widget AdaptiveIndicator(String os) {
  if (os == 'android') {
    return const Center(child:  CircularProgressIndicator());
  }
  return const Center(child:  CupertinoActivityIndicator());
}

//Switch
Widget AdaptiveSwitch({
  required String os,
  required bool value,
  required Function(bool?)? onChanged,
}) {
  if (os == 'android') {
    return Switch(value: value, onChanged: onChanged);
  }
    return CupertinoSwitch(
        value: value,
        onChanged: onChanged
    );
}
//Scaffold
Widget AdaptiveScaffold({
  required String os,
  action,
  required title,
  required Body,
  AppBarBackgroundColor
}) {
  if (os == 'android') {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarBackgroundColor,
        actions: [
          action,
        ],
        title: title,
      ),
      body: Body,
    );
  }
  return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: title,
        trailing: action,
        backgroundColor: AppBarBackgroundColor,
      ),
      child:Body,
  );
}
//tff
Widget AdaptiveTextFormField({
  required String os,
  required prefixIcon,
  suffixIcon,
  required String label,
  required Controller,
}) {
  if (os == 'android') {
   return  TextFormField(
      style: TextStyle(
        color:  HexColor('#38B090'),
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
      controller: Controller,
      decoration: InputDecoration(
          labelText:label,
          border:const OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon,color:  HexColor('#38B090'),)
      ),
    );
  }
  return CupertinoTextField(
    style: TextStyle(
      color:  HexColor('#38B090'),
      fontWeight:FontWeight.normal,
      fontSize: 15,
    ),
    controller: Controller,
    prefix:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(prefixIcon,color: HexColor('#38B090')),
    ) ,
    placeholder:label ,//Icon(CupertinoIcons.person),
  );
}
//button
Widget AdaptiveButton({
  required String os,
  required name
}) {
  if (os == 'android') {
    return TextButton(
      onPressed: () {},
      child:  Text(
        name,
        style:const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
  return CupertinoButton(
    onPressed: () {},
    child: Text(
      name,
      style:const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}