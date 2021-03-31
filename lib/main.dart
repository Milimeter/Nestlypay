import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/resources/auth_methods.dart';
import 'package:investment_app/screens/auth/login_screen.dart';
import 'package:investment_app/screens/home_screen.dart';
import 'package:investment_app/screens/main_screens/main_intro.dart';
import 'package:investment_app/screens/misc/intro_screen.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthMethods authMethods = AuthMethods();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    navigate();
    super.initState();
  }

  navigate() async {
    bool toBoarding = await getNewState();
    if (toBoarding) {
      Timer(Duration(seconds: 4), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroScreen()));
      });
    } else {
      User currentUser;
      currentUser = _firebaseAuth.currentUser;

      if (currentUser == null) {
        Timer(
            Duration(seconds: 4),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ));
      } else {
        var id = await authMethods.getCurrentUser();
        id != null
            ? FirebaseFirestore.instance
                .collection("users")
                .doc(id.uid)
                .get()
                .then((snapshot) {
                if (snapshot.exists) {
                  bool filled = snapshot.data()['infoFilled'];
                  if (filled == true) {
                    Timer(
                      Duration(seconds: 2),
                      () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      ),
                    );
                  } else {
                    Timer(
                        Duration(seconds: 6),
                        () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainIntro()),
                            (Route<dynamic> route) => false));
                  }
                }
              })
            : Timer(
                Duration(seconds: 6),
                () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainIntro()),
                    ));

        // Timer(
        //   Duration(seconds: 4),
        //   () => Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => HomeScreen()),
        //   ),
        // );
      }

      // Timer(Duration(seconds: 4), () {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // });
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
