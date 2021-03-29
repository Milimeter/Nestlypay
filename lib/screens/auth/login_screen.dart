import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/screens/auth/forgot_password.dart';
import 'package:investment_app/screens/auth/signup_screen.dart';
import 'package:investment_app/screens/main_screens/control/admin2.dart';
import 'package:investment_app/screens/main_screens/main_intro.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:investment_app/utils/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  TextEditingController _emailtextEditingController = TextEditingController();
  TextEditingController _passwordtextEditingController =
      TextEditingController();
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
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainIntro())),
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
