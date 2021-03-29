import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    TextEditingController _usernametextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
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
                  child: ListView(
                    children: [
                      Image.asset("assets/images/signup.png", width: 200),
                      TextFormField(
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
                        controller: _passwordtextEditingController,
                        obscureText: obscureText,
                        maxLength: 8,
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
                          helperText: "No more than 8 characters.",
                          icon: Icon(Icons.lock),
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                              fontSize: 14, color: UniversalColors.blueColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen())),
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
                                  builder: (context) => LoginScreen()));
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
