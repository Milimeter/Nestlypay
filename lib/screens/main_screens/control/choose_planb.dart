import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/screens/main_screens/control/start_investing.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';

class ChoosePlanB extends StatefulWidget {
  @override
  _ChoosePlanBState createState() => _ChoosePlanBState();
}

class _ChoosePlanBState extends State<ChoosePlanB> {
  Widget holder(
          {IconData icon,
          String text1,
          String text2,
          String text3,
          Color color}) =>
      Container(
        padding: EdgeInsets.all(18),
        height: 150,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AutoSizeText(
                  "$text1 ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                AutoSizeText(
                  "$text2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                AutoSizeText(
                  "$text3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            Icon(
              //LineIcons.mobilePhone,
              icon,
              color: Colors.white,
              size: 70,
            )
          ],
        ),
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
        title: AutoSizeText("Choose a plan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartInvesting(
                                  amount: "500000",
                                  currentPlan: "Emerald",
                                  payout: "650000",
                                ))),
                    child: holder(
                      icon: LineIcons.mobilePhone,
                      text1: "₦500,000",
                      text2: "Interest 30% ₦650,000",
                      text3: "Emerald",
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartInvesting(
                                  amount: "1,000,000",
                                  currentPlan: "Ruby",
                                  payout: "1300000",
                                ))),
                    child: holder(
                      icon: LineIcons.home,
                      text1: "₦1,000,000",
                      text2: "Interest 30% ₦1,300,000",
                      text3: "Ruby",
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartInvesting(
                                  amount: "2000000",
                                  currentPlan: "Diamond",
                                  payout: "2600000",
                                ))),
                    child: holder(
                      icon: LineIcons.crown,
                      text1: "₦2,000,000",
                      text2: "Interest 30% ₦2,600,000",
                      text3: "Diamond",
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: 25),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: AutoSizeText("Back",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
