import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/screens/main_screens/control/access_code.dart';
import 'package:investment_app/utils/colors.dart';

class AdminTwo extends StatefulWidget {
  @override
  _AdminTwoState createState() => _AdminTwoState();
}

class _AdminTwoState extends State<AdminTwo> {
  Widget listCard({
    String title,
    String subtitle,
    String image,
  }) =>
      Card(
          elevation: 5.0,
          shadowColor: Colors.grey,
          child: ListTile(
            // onTap: onTap,
            title: AutoSizeText(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: AutoSizeText(
              subtitle,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Image.asset(image),
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: UniversalColors.blueColor,
          leading: Image.asset("assets/images/vr.png"), 
          title: AutoSizeText("Welcome back \n Admin"),
          actions: [
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccessCode()),
              ),
              child: Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   SizedBox(height: 20),
                  Image.asset("assets/images/graph.png"),
                  SizedBox(height: 20),
                  listCard(
                      title: "No of Users",
                      subtitle: "17,021",
                      image: "assets/images/pica.png"),
                      SizedBox(height: 20),
                  listCard(
                      title: "No of Investors",
                      subtitle: "16,321",
                      image: "assets/images/picb.png"),
                      SizedBox(height: 20),
                  listCard(
                      title: "No of Online Investors",
                      subtitle: "14 Users",
                      image: "assets/images/post.png"),
                      SizedBox(height: 20),
                  listCard(
                      title: "No of revenue received",
                      subtitle: "12,000,000",
                      image: "assets/images/post.png"),
                ],
              ),
            ),
          ),
        ));
  }
}
