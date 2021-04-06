import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/utils/colors.dart';

class ReferralPage extends StatefulWidget {
  @override
  _ReferralPageState createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  Widget shareLink() => Container(
        margin: EdgeInsets.all(10),
        height: 48,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(8)),
        child: Center( 
            child: AutoSizeText(
          "Share Link",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        )),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: 8,
                ),
                ListTile(
                  title: AutoSizeText(
                    "Your Referrals",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  trailing: AutoSizeText(
                    "0",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                ListTile(
                  title: AutoSizeText(
                    "Total Referral \n Earnings",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  trailing: AutoSizeText(
                    "0:00",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: Colors.grey),
                Image.asset("assets/images/refer.png",fit: BoxFit.cover),
                SizedBox(height: 8),
                AutoSizeText(
                  "You Earn 5% bonus on each\n referral investment",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shareLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
