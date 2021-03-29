import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/screens/main_screens/fill_info.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:investment_app/utils/custom_button.dart';

class MainIntro extends StatefulWidget {
  @override
  _MainIntroState createState() => _MainIntroState();
}

class _MainIntroState extends State<MainIntro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: UniversalColors.whiteColor,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                
              ),
              SizedBox(height: 24),
              Image.asset("assets/images/welcome.png", width: 200,),
              SizedBox(height: 24,),
              AutoSizeText(
                "Start Achieving your goals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FillInfo())),
                  child: CustomButton(
                    label: 'Continue',
                    labelColour: Colors.white,
                    backgroundColour: UniversalColors.blueColor,
                    shadowColour: UniversalColors.blueColor.withOpacity(0.16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
