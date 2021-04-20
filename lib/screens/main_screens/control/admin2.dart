import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                // listCard(
                //     title: "No of Users",
                //     subtitle: "17,021",
                //     image: "assets/images/pica.png"),

                // listCard(
                //     title: "No of Investors",
                //     subtitle: "16,321",
                //     image: "assets/images/picb.png"),

                StreamBuilder<QuerySnapshot>(
                  // <2> Pass `Stream<QuerySnapshot>` to stream
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length == 0) {
                        return listCard(
                            title: "No of Users",
                            subtitle: "0",
                            image: "assets/images/pica.png");
                      } else {
                        return listCard(
                            title: "No of Users",
                            subtitle: snapshot.data.docs.length.toString(),
                            image: "assets/images/pica.png");
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                  // <2> Pass `Stream<QuerySnapshot>` to stream
                  stream: FirebaseFirestore.instance
                      .collection('userPayments')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length == 0) {
                        return listCard(
                            title: "No of Investors",
                            subtitle: "0",
                            image: "assets/images/picb.png");
                      } else {
                        return listCard(
                            title: "No of Investors",
                            subtitle: snapshot.data.docs.length.toString(),
                            image: "assets/images/picb.png");
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                // SizedBox(height: 20),
                // listCard(
                //     title: "No of Online Investors",
                //     subtitle: "14 Users",
                //     image: "assets/images/post.png"),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                  // <2> Pass `Stream<QuerySnapshot>` to stream
                  stream: FirebaseFirestore.instance
                      .collection('AppRevenue')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length == 0) {
                        return listCard(
                            title: "No of revenue received",
                            subtitle: "0",
                            image: "assets/images/post.png");
                      } else {
                        return listCard(
                            title: "No of revenue received",
                            subtitle: snapshot.data.docs.first.data()["appRevenue"].toString(),
                            image: "assets/images/post.png");
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                // listCard(
                //     title: "No of revenue received",
                //     subtitle: "12,000,000",
                //     image: "assets/images/post.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
