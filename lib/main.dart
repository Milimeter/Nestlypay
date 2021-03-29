import 'dart:async';

import 'package:flutter/material.dart';
import 'package:investment_app/screens/auth/login_screen.dart';
import 'package:investment_app/screens/misc/intro_screen.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  navigate() async {
    bool toBoarding = await getNewState();
    if (toBoarding) {
      Timer(Duration(seconds: 4), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroScreen()));
      });
    }else{
      Timer(Duration(seconds: 4), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }

  }

  getNewState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newUser =
        prefs.getBool("newUser") == null || prefs.getBool("newUser") == true
            ? true
            : false;
    return newUser;
  }
  @override
  void initState() {
    navigate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UniversalColors.whiteColor,
      appBar: AppBar(
        backgroundColor: UniversalColors.whiteColor,
        elevation: 0.0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Image.asset("assets/images/logo.png", fit: BoxFit.fill),
        ),
      ),
    );
  }
}
