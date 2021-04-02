import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  TextEditingController _fullNameTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _phoneNoTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Position _currentPosition;
  String _currentAddress;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Widget box({String text, Color color}) => Container(
        margin: EdgeInsets.all(10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: AutoSizeText(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        )),
      );

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserData user = userProvider.getUser;
    _fullNameTextEditingController.text = user.name;
    _emailTextEditingController.text = user.email;
    _phoneNoTextEditingController.text = user.phoneNo;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: UniversalColors.whiteColor,
        leading: Container(
          margin: EdgeInsets.only(left: 9),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue[800]),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png"),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText("Personal Info",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25)),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _fullNameTextEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.perm_contact_cal_outlined),
                        hintText: "Full name"),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _emailTextEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.attach_email),
                        hintText: "Email Address"),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _phoneNoTextEditingController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.mobile_friendly),
                        hintText: "Phone Number"),
                  ),
                  SizedBox(height: 25),
                  ListTile(
                    title: AutoSizeText(
                      _currentAddress != null ? _currentAddress : "Loading",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(Icons.location_history, color: Colors.black),
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       border: UnderlineInputBorder(),
                  //       suffixIcon: Icon(Icons.location_history),
                  //       hintText: "Location"),
                  // ),
                  SizedBox(height: 30),
                  box(
                    color: Colors.blue,
                    text: "Next",
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //     height: 100,
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage(
                  //             "assets/images/btnback.png",
                  //           ),
                  //           fit: BoxFit.fill),
                  //     ),
                  //     child: Align(
                  //       alignment: Alignment.center,
                  //       child: AutoSizeText(
                  //         "Next",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
