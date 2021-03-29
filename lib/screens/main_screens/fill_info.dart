import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: UniversalColors.whiteColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
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
                    controller: _fullNametextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.card_travel),
                      hintText: "Full Name",
                      border: UnderlineInputBorder(),
                    )),
                SizedBox(height: 25),
                TextFormField(
                    controller: _contactAddresstextEditingController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person),
                      hintText: "Contact Address",
                      border: UnderlineInputBorder(),
                    )),
                SizedBox(height: 25),
                TextFormField(
                    controller: _phoneNotextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.mobile_friendly),
                      hintText: "Phone Number",
                      border: UnderlineInputBorder(),
                    )),
                SizedBox(height: 25),
                TextFormField(
                    controller: _refLinktextEditingController,
                    keyboardType: TextInputType.phone,
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
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen())),
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
      ),
    );
  }
}
