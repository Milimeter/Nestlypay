import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/resources/auth_methods.dart';
import 'package:investment_app/screens/auth/login_screen.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:investment_app/utils/custom_button.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailtextEditingController = TextEditingController();
  AuthMethods _authMethods = AuthMethods();
  _showVerifyEmailDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Password Reset"),
          content: new Text(
              "Your password reset link has been sent to the email provided"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () async {
                // await _resentVerifyEmail();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
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
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context)),
                    Text("Forgot Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: size.height,
              width: size.width,
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Form(
                  child: ListView(
                    children: [
                      Image.asset("assets/images/forgot_password.png",
                          width: 200),
                      AutoSizeText(
                        'Enter your email for the verification process, and we will send 4 digit code to your email for verification ',
                        style: TextStyle(fontSize: 30.0),
                        maxLines: 2,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailtextEditingController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          icon: Icon(Icons.mail),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: GestureDetector(
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LoginScreen())),
                          onTap: () async {
                            await _authMethods.sendPasswordResetMail(
                                _emailtextEditingController.text);
                            _showVerifyEmailDialog();
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
            ),
          )
        ],
      ),
    );
  }
}
