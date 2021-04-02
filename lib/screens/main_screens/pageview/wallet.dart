import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/screens/main_screens/control/see_all_plans.dart';
import 'package:investment_app/screens/main_screens/control/withdraw.dart';
import 'package:investment_app/utils/colors.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  Widget payout() => Container(
        padding: EdgeInsets.all(8),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.blueGrey,
                Colors.orange,
              ]),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset("assets/images/eurofull.png"),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  title: AutoSizeText(
                    "Garnet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: AutoSizeText(
                    "100,000",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Expired on 08 Sept 2021",
                        style: TextStyle(color: Colors.white),
                      ),
                      Column(
                        children: [
                          AutoSizeText(
                            "Payout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 2),
                          AutoSizeText(
                            "150,000",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );

      Widget noPayout() => Container(
        padding: EdgeInsets.all(8),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.blueGrey,
                Colors.orange,
              ]),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset("assets/images/eurofull.png"),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  title: AutoSizeText(
                    "Garnet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: AutoSizeText(
                    "₦0",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "No Plans",
                        style: TextStyle(color: Colors.white),
                      ),
                      Column(
                        children: [
                          AutoSizeText(
                            "Payout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 2),
                          AutoSizeText(
                            "₦0",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );

  Widget refBonus() => Container(
        padding: EdgeInsets.all(8),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blueGrey,
                Colors.blue[600],
                Colors.blueGrey,
                Colors.pink[300]
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "Your total referral bonus",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              AutoSizeText(
                "₦0",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      );

  Widget withdraw() => Container(
        height: 48,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(14)),
        child: Center(
            child: AutoSizeText(
          "Withdraw",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        )),
      );
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: UniversalColors.whiteColor,
        title: Text(
          "My Wallet",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "Your total asset balance",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            AutoSizeText(
              "₦0",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            AutoSizeText(
              "Current Plans",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            payout(),
            SizedBox(height: 15),
            refBonus(),
            SizedBox(height: size.height * 0.10),
            GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WithdrawMoney()),
                    ),
                child: withdraw()),
            SizedBox(height: 18),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Plans()),
                ),
                child: AutoSizeText(
                  "See all plans ->",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
