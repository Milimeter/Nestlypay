import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithdrawRequest extends StatefulWidget {
  @override
  _WithdrawRequestState createState() => _WithdrawRequestState();
}

class _WithdrawRequestState extends State<WithdrawRequest> {
  bool isLoading = false;
  Widget withdrawButton({
    String name,
    String amountToPay,
    String amountPaid,
    String planType,
    String uid,
    String uniqueId,
    String token,
  }) {
    return Container(
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
          AutoSizeText(name,
              style: TextStyle(
                color: Colors.white,
              )),
          AutoSizeText("Amount Paid ₦$amountPaid",
              style: TextStyle(
                color: Colors.white,
              )),
          AutoSizeText(planType,
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
                  "₦$amountToPay",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    acknowledge(
                      amountPaid: amountPaid,
                      uid: uid,
                      uniqueId: uniqueId,
                      token: token,
                    );
                  },
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
  }

  acknowledge({String amountPaid, String uid, String uniqueId, String token}) {
    setState(() {
      isLoading = true;
    });
    // sendNotification("Your Withdrawal request will be handled withing 48 hours",
    //     "NestlyPay", token);
    FirebaseFirestore.instance
        .collection("userAssets")
        .doc(uid)
        .get()
        .then((value) {
      if (value.exists) {
        int newBalance = value.data()["assetBalance"] - int.parse(amountPaid);
        FirebaseFirestore.instance.collection("userAssets").doc(uid).update({
          "assetBalance": newBalance,
        });
        FirebaseFirestore.instance
            .collection("userPayments")
            .doc(uniqueId)
            .delete();
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  var serverkey =
      "AAAA2I9Tjmk:APA91bG7Wv3KSprKjbWZbi6MfvJLtLJi3bhhiGck0P9nzNlDfFqKiChVlMOp3MQnQoq7fNgyGX4AUX-2NxmYLslRMM0WDRwVq15WVPWkxpL134JFStd3LY1Nm0ynjdZlN5y0XLEsXgOw";

  // Future<void> sendNotification(
  //     String message, String sender, String receiver) async {
  //   print("Firebase Token: " + receiver);
  //   FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //   await http.post(
  //     'https://fcm.googleapis.com/fcm/send',
  //     headers: <String, String>{
  //       'Authorization': 'key=$serverkey',
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       // "message": {
  //       "to": "$receiver",
  //       "collapse_key": "type_a",
  //       "priority": "high",
  //       "notification": {
  //         "title": "$sender",
  //         "body": "$message",
  //       },
  //       "data": {
  //         "title": "$sender",
  //         "body": "$message",
  //         "sound": "default",
  //         "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //       }
  //       // }
  //     }),
  //   );
  //   final Completer<Map<String, dynamic>> completer =
  //       Completer<Map<String, dynamic>>();

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       completer.complete(message);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
              stream: FirebaseFirestore.instance
                  .collection('WithdrawRequest')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text("No withdraw request at the moment"),
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
                        return withdrawButton(
                            name: snapshot.data.docs[index].data()["username"],
                            amountToPay:
                                snapshot.data.docs[index].data()["amounttoPay"],
                            amountPaid:
                                snapshot.data.docs[index].data()["amountPaid"],
                            planType:
                                snapshot.data.docs[index].data()["amountPaid"],
                            uid: snapshot.data.docs[index].data()["uid"],
                            uniqueId:
                                snapshot.data.docs[index].data()["uniqueId"],
                            token: snapshot.data.docs[index]
                                .data()["userFCMToken"]);
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
