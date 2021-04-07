import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/resources/auth_methods.dart';
import 'package:investment_app/screens/auth/login_screen.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:investment_app/utils/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscureText = true;
  TextEditingController _emailtextEditingController = TextEditingController();
  TextEditingController _passwordtextEditingController =
      TextEditingController();
  TextEditingController _usernametextEditingController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  AuthMethods authMethods = AuthMethods();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  /// Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  validateAndSubmit() async {
    print("authentication process");
    if (_validateAndSave()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await authMethods.signUp(_emailtextEditingController.text,
            _passwordtextEditingController.text);
        User currentUser;
        currentUser = _auth.currentUser;

        await authMethods.sendEmailVerification();

        //FirebaseUser user = await _auth.currentUser;
        await authMethods.addDataToDb(
          currentUser: currentUser,
          username: _usernametextEditingController.text.trim(),
          password: _passwordtextEditingController.text.trim(),
        );

        String userId = currentUser.uid;
        //authMethods.signOut();
        _showVerifyEmailSentDialog();
        print('Signed up user: $userId');
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
        });
        Get.snackbar(
          "Error!",
          "${e.toString()}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          duration: Duration(seconds: 5),
        );
      }
    }
    print("Validate Error");
    setState(() {
      _isLoading = false;
    });
  }

  _showVerifyEmailSentDialog() {
    return showDialog(
      barrierDismissible: false,
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
                //_changeFormToLogin();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    child: Text("Sign Up",
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
                      Image.asset("assets/images/signup.png", width: 200),

                      SizedBox(height: 24),
                      TextFormField(
                        validator: (name) {
                          // Pattern pattern =
                          //     r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                          // RegExp regex = new RegExp(pattern);
                          if (name.isEmpty)
                            return 'Invalid username';
                          else
                            return null;
                        },
                        controller: _usernametextEditingController,
                        decoration: InputDecoration(
                          hintText: "Your username",
                          icon: Icon(Icons.mobile_friendly_rounded),
                          labelText: "Username",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        validator: (String value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Enter Valid Email';
                          else
                            return null;
                        },
                        controller: _emailtextEditingController,
                        decoration: InputDecoration(
                          hintText: "Your email address",
                          icon: Icon(Icons.email),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        validator: (password) {
                          Pattern pattern =
                              r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(password))
                            return 'At least one letter, At least one number, and be longer than six charaters';
                          else
                            return null;
                        },
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
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      //   child: Text(
                      //     "Forgot your password?",
                      //     style: TextStyle(
                      //         fontSize: 14, color: UniversalColors.blueColor),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: GestureDetector(
                          onTap: () => validateAndSubmit(),
                          child: CustomButton(
                            label: 'Continue',
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
                              text: 'Already have an account?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Log in',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                        // navigate to desired screen
                                      })
                              ]),
                        ),
                      ),
                      // SizedBox(height: 10),
                      // Container(
                      //     alignment: Alignment.center,
                      //     child: Text("-------- or Login with --------")),
                      // SizedBox(height: 10),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 35.0),
                      //   child: GestureDetector(
                      //     onTap: () => Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => HomeScreen())),
                      //     child: CustomButton(
                      //       label: 'Login as Admin',
                      //       labelColour: Colors.blue,
                      //       backgroundColour: UniversalColors.whiteColor,
                      //       shadowColour:
                      //           UniversalColors.blueColor.withOpacity(0.16),
                      //     ),
                      //   ),
                      // ),
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
