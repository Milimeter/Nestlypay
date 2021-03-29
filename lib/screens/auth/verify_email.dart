import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/utils/colors.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: UniversalColors.whiteColor,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AutoSizeText(
                "Verify\nYour Email",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Image.asset("assets/images/forgot_password.png", width: 350.0),
              AutoSizeText(
                "Please Enter the 4 digit code already sent to\nopeyemicharles@gmail.com",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
