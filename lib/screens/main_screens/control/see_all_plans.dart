import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/screens/main_screens/control/choose_plan.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Plans extends StatefulWidget {
  final List currentPlans;

  const Plans({Key key, this.currentPlans}) : super(key: key);
  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  // Widget plansList(){
  //   for( var plansName in widget.currentPlans){
  //     switch(plansName){
  //       case "Pearl":
  //         return

  //     }
  //   }
  // }
  Widget plansList({String plan, String fullName, String payoutAmount}) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[900],
              Colors.blue[300],
              Colors.blue[900],
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Visa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    AutoSizeText(
                      plan,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    AutoSizeText(
                      payoutAmount,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(LineIcons.creditCardAlt, color: Colors.white)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText(
                      ". . . .",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      ". . . .",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      ". . . .",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    AutoSizeText(
                      "2 4 5 7",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: AutoSizeText(
                    fullName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rubyPlans() => Container(
        padding: EdgeInsets.all(8),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange[700],
                Colors.orange[900],
                Colors.orange[200],
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "Visa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      AutoSizeText(
                        "Ruby",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      AutoSizeText(
                        "100,000",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(LineIcons.creditCardAlt, color: Colors.white)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText(
                        ". . . .",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        ". . . .",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        ". . . .",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        "2 4 5 7",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AutoSizeText(
                      "Charles Emmaah",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget getNewPackage() => Container(
        height: 90,
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue[100], borderRadius: BorderRadius.circular(29)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(19),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: AutoSizeText(
                  "Add New Package",
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserData user = userProvider.getUser;
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
        title: AutoSizeText("My Packages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                // <2> Pass `Stream<QuerySnapshot>` to stream
                stream: FirebaseFirestore.instance
                    .collection('userPackages')
                    .where("uid", isEqualTo: user.uid)
                    .orderBy("timeStamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length == 0) {
                      return Column(children: [
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/noPackages.png",
                              width: 200),
                        ),
                        SizedBox(height: 20),
                        AutoSizeText(
                          "No Packages Yet!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 25),
                        // GestureDetector(
                        //   onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ChoosePlan()),
                        //   ),
                        //   child: Align(
                        //     alignment: Alignment.bottomCenter,
                        //     child: getNewPackage(),
                        //   ),
                        // )
                      ]);
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print(snapshot.data.docs[index].data());
                          // return postThread(
                          //   title: snapshot.data.docs[index].data()["Title"],
                          //   description:
                          //       snapshot.data.docs[index].data()["Description"],
                          // );
                          return plansList(
                            plan:
                                snapshot.data.docs[index].data()["currentPlan"],
                            payoutAmount:
                                snapshot.data.docs[index].data()["payout"],
                            fullName: user.name,
                          );
                        },
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            SizedBox(height: 25),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChoosePlan()),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: getNewPackage(),
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
