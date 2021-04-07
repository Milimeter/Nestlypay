import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/models/user_assets.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/provider/user_assets_provider.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/screens/main_screens/control/choose_plan.dart';
import 'package:investment_app/screens/main_screens/control/create_post.dart';
import 'package:investment_app/screens/main_screens/control/notification_page.dart';
import 'package:investment_app/screens/main_screens/control/start_investing.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// The widget that shows the wallet amount and "Invest Now" button
  Widget assetBalance({int assetBalance}) => Container(
        padding: EdgeInsets.all(10),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.blue[900],
              Colors.blue,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 4,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText("Your total asset Balance",
                style: TextStyle(
                  color: Colors.white,
                )),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "₦${assetBalance.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChoosePlan())),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: AutoSizeText(
                        "Invest Now",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget plansWidget(
          {Color color1,
          Color color2,
          String title,
          String subtitle,
          IconData icon}) =>
      Container(
        height: 150,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              color1,
              color2,
            ],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                icon,
                color: Colors.white,
                size: 60,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15),
                child: Column(
                  children: [
                    AutoSizeText(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    AutoSizeText(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
    );
    UserAssetsProvider userAssetsProvider = Provider.of(
      context,
    );
    UserData user = userProvider.getUser;
    UserAssets userAssets = userAssetsProvider.getAssets;
    var ns = user.name.split(" ");

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: UniversalColors.whiteColor,
        leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black), onPressed: () {}),
        actions: [
          GestureDetector(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreatePost()),
                  ),
              child: Image.asset("assets/images/vr.png")),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: ListView(
            children: [
              AutoSizeText("Welcome ${ns[0]}",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              assetBalance(assetBalance: userAssets.assetBalance),
              SizedBox(height: size.height * 0.10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "Best Plans",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChoosePlan()),
                    ),
                    child: AutoSizeText("See All ->",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartInvesting(
                                      amount: "20000",
                                      currentPlan: "Coral",
                                      payout: "26000",
                                    ))),
                        child: plansWidget(
                          color1: Colors.yellow[900],
                          color2: Colors.yellow,
                          icon: LineIcons.mobilePhone,
                          title: "Coral",
                          subtitle: "30% return",
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartInvesting(
                                      amount: "50000",
                                      currentPlan: "Pearl",
                                      payout: "65000",
                                    ))),
                        child: plansWidget(
                          color1: Colors.grey,
                          color2: Colors.green[600],
                          icon: LineIcons.home,
                          title: "Pearl",
                          subtitle: "30% return",
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartInvesting(
                                      amount: "100000",
                                      currentPlan: "Garnet",
                                      payout: "130000",
                                    ))),
                        child: plansWidget(
                          color1: Colors.blue,
                          color2: Colors.blue[900],
                          icon: LineIcons.crown,
                          title: "Garnet",
                          subtitle: "30% return",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AutoSizeText("Investment Guide",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                  // <2> Pass `Stream<QuerySnapshot>` to stream
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy("timeStamp", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length == 0) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/picb.png"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              title: AutoSizeText(
                                "How much can you start with",
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: AutoSizeText(
                                "What do you like to see? It is a very market from 2021",
                              ),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/pica.png"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              title: AutoSizeText("Basic Type of investments"),
                              subtitle: AutoSizeText(
                                  "This is how you set foot on your 2021 stock market recession"),
                            ),
                          ],
                        );
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
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/picb.png"),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              title: AutoSizeText(
                                snapshot.data.docs[index].data()["Title"],
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: AutoSizeText(
                                snapshot.data.docs[index].data()["Description"],
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
