import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/resources/auth_methods.dart';
import 'package:investment_app/screens/home_screen.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:investment_app/utils/custom_button.dart';

class FillInfo extends StatefulWidget {
  @override
  _FillInfoState createState() => _FillInfoState();
}

class _FillInfoState extends State<FillInfo> {
  TextEditingController _fullNametextEditingController =
      TextEditingController();
  TextEditingController _contactAddresstextEditingController =
      TextEditingController();
  TextEditingController _phoneNotextEditingController = TextEditingController();
  TextEditingController _refLinktextEditingController = TextEditingController();
  bool checkedValue = false;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  _validateAndSubmit() async {
    print("auth started");
    if (_validateAndSave()) {
      setState(() {
        isLoading = true;
      });

      try {
        User currentUser;
        currentUser = _auth.currentUser;

        print("auth started2");

        //FirebaseUser user = await _auth.currentUser;
        print("updating data");
        await authMethods.updateDataInDb(
          currentUser: currentUser,
          name: _fullNametextEditingController.text.trim(),
          contactAddress: _contactAddresstextEditingController.text.trim(),
          phoneNo: _phoneNotextEditingController.text.trim(),
          refLink: _refLinktextEditingController.text.trim(),
        );
        print("updated data");

        String userId = currentUser.uid;
        print('Signed up user: $userId');
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

       
      } catch (e) {
        print('Error: $e');
        setState(() {
          isLoading = false;
        });
        Get.snackbar(
          "Error!",
          "${e.toString()}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
      }
    } else {
      Get.snackbar(
        "Error!",
        "Unknown Error, try again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: UniversalColors.whiteColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            isLoading ? Center(child: CircularProgressIndicator()) : SizedBox(),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png"),
                    // SizedBox(height: 5),
                    AutoSizeText(
                      "Fill your Information",
                      style: TextStyle(fontSize: 28),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        textCapitalization: TextCapitalization.words,
                        validator: (String value) {
                          return value.isEmpty
                              ? "Full Name can't be empty"
                              : null;
                        },
                        controller: _fullNametextEditingController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.card_travel),
                          hintText: "Full Name",
                          border: UnderlineInputBorder(),
                        )),
                    SizedBox(height: 25),
                    TextFormField(
                        validator: (String value) {
                          return value.isEmpty
                              ? "Full Name can't be empty"
                              : null;
                        },
                        textCapitalization: TextCapitalization.words,
                        controller: _contactAddresstextEditingController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.person),
                          hintText: "Contact Address",
                          border: UnderlineInputBorder(),
                        )),
                    SizedBox(height: 25),
                    TextFormField(
                        validator: (String value) {
                          if (value.length > 14) {
                            return " Phone number length should be 14";
                          } else {
                            return null;
                          }
                        },
                        controller: _phoneNotextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.mobile_friendly),
                          hintText: "Phone Number '080'",
                          border: UnderlineInputBorder(),
                        )),
                    SizedBox(height: 25),
                    TextFormField(
                        validator: (String value) {
                          return value.isEmpty ? null : null;
                        },
                        controller: _refLinktextEditingController,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.mobile_friendly),
                          hintText: "Referral Link (optional)",
                          border: UnderlineInputBorder(),
                        )),
                    SizedBox(height: 20),
                    CheckboxListTile(
                      title: Text("I accept the terms and condition"),
                      value: checkedValue,
                      onChanged: (newValue) {
                        setState(() {
                          checkedValue = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                      child: GestureDetector(
                        // onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeScreen())),
                        onTap: () {
                          if (checkedValue == false) {
                            Get.snackbar(
                              "Error",
                              "You have to accept the terms and condition to continue",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.white,
                              colorText: Colors.black,
                            );
                          } else {
                            _validateAndSubmit();
                          }
                        },
                        child: CustomButton(
                          label: 'Continue',
                          labelColour: Colors.white,
                          backgroundColour: UniversalColors.blueColor,
                          shadowColour:
                              UniversalColors.blueColor.withOpacity(0.16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
