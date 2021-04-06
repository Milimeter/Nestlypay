import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/resources/auth_methods.dart';
import 'package:investment_app/screens/auth/forgot_password.dart';
import 'package:investment_app/screens/auth/signup_screen.dart';
import 'package:investment_app/screens/home_screen.dart';
import 'package:investment_app/screens/main_screens/control/admin2.dart';
import 'package:investment_app/screens/main_screens/main_intro.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:investment_app/utils/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool obscureText = true;
  TextEditingController _emailtextEditingController = TextEditingController();
  TextEditingController _passwordtextEditingController =
      TextEditingController();
  AuthMethods authMethods = AuthMethods();
  bool _isLoading = false;
  bool _isEmailVerified = false;
  String errorMessage;
  @override
  dispose() {
    _passwordtextEditingController.clear();
    _emailtextEditingController.clear();
    super.dispose();
  }

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  // performs signup
  void validateAndSubmit() async {
    print("performing login...");
    if (_validateAndSave()) {
      setState(() {
        _isLoading = true;
      });
      String userId = "";
      try {
        await authMethods.signIn(_emailtextEditingController.text.trim(),
            _passwordtextEditingController.text.trim());
        print("signedIn ================>>>>>>>");
        await _checkEmailVerification();
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomeScreen()));

        print('Signed up user: $userId');
      } catch (error) {
        print('Error: $error');
        setState(() {
          _isLoading = false;
        });

        switch (error.code) {
          case "ERROR_INVALID_EMAIL":
            errorMessage = "Your email address appears to be malformed.";
            return Get.snackbar(
              "Error!",
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              duration: Duration(seconds: 5),
            );

            break;
          case "ERROR_WRONG_PASSWORD":
            errorMessage = "Your password is wrong.";
            return Get.snackbar(
              "Error!",
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              duration: Duration(seconds: 5),
            );
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist.";
            return Get.snackbar(
              "Error!",
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              duration: Duration(seconds: 5),
            );
            break;
          case "ERROR_USER_DISABLED":
            errorMessage = "User with this email has been disabled.";
            return Get.snackbar(
              "Error!",
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              duration: Duration(seconds: 5),
            );
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            errorMessage = "Too many requests. Try again later.";
            return Get.snackbar(
              "Error!",
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              duration: Duration(seconds: 5),
            );
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled.";
            return Get.snackbar(
              "Error!",
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              duration: Duration(seconds: 5),
            );
            break;
          default:
            errorMessage = "An undefined Error happened.";
            return Get.snackbar(
              "Error!",
              errorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              duration: Duration(seconds: 5),
            );
        }
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  _checkEmailVerification() async {
    _isEmailVerified = await authMethods.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    } else {
      // bool dataAdded = prefs.getBool("addedData") == null ||
      //         prefs.getBool("addedData") == false
      //     ? false
      //     : true;
      // if (dataAdded) {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => HomeScreen()),
      //       (Route<dynamic> route) => false);
      // } else {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => MainIntro()),
      //     (Route<dynamic> route) => false);
      // }
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
                          MaterialPageRoute(builder: (context) => MainIntro()),
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
    }
  }

  Future<void> _resentVerifyEmail() async {
    await authMethods.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  _showVerifyEmailDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resend link"),
              onPressed: () async {
                await _resentVerifyEmail();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: size.height * 0.05,
                width: size.width * 0.50,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: UniversalColors.blueColor,
                ),
                child: Center(
                    child: Text("Log in",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: size.height,
              width: size.width,
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Image.asset("assets/images/login.png", width: 200),
                      TextFormField(
                          controller: _emailtextEditingController,
                          decoration: InputDecoration(
                              hintText: "Your email address",
                              icon: Icon(Icons.email),
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20))),
                      SizedBox(height: 24),
                      TextFormField(
                          controller: _passwordtextEditingController,
                          obscureText: obscureText,
                          maxLength: 14,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: Icon(obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              hintText: "Enter your password",
                              helperText: "No more than 14 characters.",
                              icon: Icon(Icons.lock),
                              labelText: "Password",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20))),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword())),
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                                fontSize: 14, color: UniversalColors.blueColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: GestureDetector(
                          onTap: () {
                            validateAndSubmit();
                          },
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MainIntro())),
                          child: CustomButton(
                            label: 'Login',
                            labelColour: Colors.white,
                            backgroundColour: UniversalColors.blueColor,
                            shadowColour:
                                UniversalColors.blueColor.withOpacity(0.16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Sign up',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen()));
                                        // navigate to desired screen
                                      })
                              ]),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          alignment: Alignment.center,
                          child: Text("-------- or Login with --------")),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminTwo())),
                          child: CustomButton(
                            label: 'Login as Admin',
                            labelColour: Colors.blue,
                            backgroundColour: UniversalColors.whiteColor,
                            shadowColour:
                                UniversalColors.blueColor.withOpacity(0.16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class PasswordField extends StatefulWidget {
//   final Key fieldKey;
//   final String labelText;
//   final String helperText;
//   final FormFieldSetter<String> onSaved;
//   @override
//   _PasswordFieldState createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
