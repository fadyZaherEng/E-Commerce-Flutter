// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, no_logic_in_create_state, must_call_super
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/layout/home_screen.dart';
import 'package:flutter_technical_task/modules/login/login_screen.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';

class SplashScreen extends StatefulWidget {
  String? name;

  SplashScreen(this.name);

  @override
  State<SplashScreen> createState() => _SplashScreenState(name);
}

class _SplashScreenState extends State<SplashScreen> {
  String? name;

  _SplashScreenState(this.name);
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      if (name == 'home') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  HomeScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedHelper.get(key: 'theme') == 'Light Theme'
          ? Colors.white
          : Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SafeArea(
          child: CircleAvatar(
            radius: 144,
            backgroundColor: SharedHelper.get(key: 'theme') == 'Light Theme'
                ? Colors.grey[200]
                : Colors.white,
            child: CircleAvatar(
              radius: 140,
              backgroundColor: SharedHelper.get(key: 'theme') == 'Light Theme'
                  ? Colors.white
                  : Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                padding: const EdgeInsetsDirectional.all(10),
                width: 280,
                height: 280,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(140)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
