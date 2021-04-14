import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/provider/user_assets_provider.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  UserProvider userProvider;
  UserAssetsProvider userAssetsProvider;
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userAssetsProvider =
        Provider.of<UserAssetsProvider>(context, listen: false);
    super.initState();
  }

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
          title: AutoSizeText("N O T I F I C A T I O N S",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // child: StreamBuilder<QuerySnapshot>(
          //     // <2> Pass `Stream<QuerySnapshot>` to stream
          //     stream: FirebaseFirestore.instance
          //         .collection('posts')
          //         .orderBy("timeStamp", descending: true)
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //           itemCount: snapshot.data.docs.length,
          //           shrinkWrap: true,
          //           itemBuilder: (context, index) {
          //             print(snapshot.data.docs[index].data());
          // return postThread(
          //   title: snapshot.data.docs[index].data()["Title"],
          //   description:
          //       snapshot.data.docs[index].data()["Description"],
          // );
          //           },
          //         );
          //       } else if (!snapshot.hasData) {
          //         return Center(child: Text(" No Notification"));
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     }),
          child: StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy("timeStamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(child: AutoSizeText("No posts at the moment"));
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
                        return postThread(
                          title: snapshot.data.docs[index].data()["Title"],
                          description:
                              snapshot.data.docs[index].data()["Description"],
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
        ));
 
  }

  Widget postThread({String title, String description}) {
    return Container(
        child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.notification_important),
          title: AutoSizeText(title),
          subtitle: AutoSizeText(description),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Divider(),
        ),
      ],
    ));
  }
}
