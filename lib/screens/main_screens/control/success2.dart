import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/screens/home_screen.dart';

class SuccessTwo extends StatefulWidget {
  @override
  _SuccessTwoState createState() => _SuccessTwoState();
}

class _SuccessTwoState extends State<SuccessTwo> {
  Widget box() => Container(
        margin: EdgeInsets.all(10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue[800], borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: AutoSizeText(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        )),
      );
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.purple, Colors.pink])),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  "Yeah! You did it",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Stack(alignment: Alignment.center, children: [
                  CircleAvatar(
                    backgroundColor: Colors.white60,
                    radius: 180,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 138.0),
                    child: Image.asset("assets/images/person.png"),
                  )
                ]),
                SizedBox(height: 10),
                AutoSizeText(
                  "Your Investment was \n Successfully",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        ),
                    child: box())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
