import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/utils/colors.dart';

class AccessCode extends StatefulWidget {
  @override
  _AccessCodeState createState() => _AccessCodeState();
}

class _AccessCodeState extends State<AccessCode> {
   Widget box() => Container(
        margin: EdgeInsets.all(10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue[800], borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: AutoSizeText(
          "Next",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        )),
      );
  @override
  Widget build(BuildContext context) {
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
          // title:
          //     AutoSizeText("Create Post", style: TextStyle(color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/access.png"),
                  AutoSizeText("Enter The Access Code",
                      style: TextStyle(color: Colors.black)),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  box(),
                ],
              ),
            ),
          ),
        ));
  }
}
