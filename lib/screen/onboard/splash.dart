import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pelindo_travel/screen/beranda/beranda_screen.dart';
import 'package:pelindo_travel/screen/home/home_screen.dart';
import 'package:pelindo_travel/screen/login/login_screen.dart';
import 'package:pelindo_travel/screen/onboard/intro.dart';
import 'package:pelindo_travel/screen/onboard/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // late User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedSplashScreen.withScreenFunction(
        duration: 3000,
        splash: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        screenFunction: () async {
          SharedPreferences sharedPreferences;
          sharedPreferences = await SharedPreferences.getInstance();
          print(sharedPreferences.getString("introkun"));
          if (sharedPreferences.getString("introkun") == null) {
            return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) => Intro()),
                (Route<dynamic> route) => false);
          }

          return Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
              (Route<dynamic> route) => false);
        },
        splashTransition: SplashTransition.fadeTransition,
        // pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}
