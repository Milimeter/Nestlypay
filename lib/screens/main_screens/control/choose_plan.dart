import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/screens/main_screens/control/choose_planb.dart';
import 'package:investment_app/screens/main_screens/control/start_investing.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';

class ChoosePlan extends StatefulWidget {
  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
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
                  "$text1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                AutoSizeText(
                  "$text2",
                  style: TextStyle(color: Colors.white, fontSize: 10),
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
            child: Column(
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
                  child: holder(
                    icon: LineIcons.mobilePhone,
                    text1: "₦20,000",
                    text2: "Interest 30% ₦26,000",
                    text3: "Coral",
                    color: Colors.orange[800],
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StartInvesting(
                                amount: "50000",
                                currentPlan: "Pearl",
                                payout: "65000",
                              ))),
                  child: holder(
                    icon: LineIcons.home,
                    text1: "₦50,000",
                    text2: "Interest 30% ₦65,000",
                    text3: "Pearl",
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StartInvesting(
                                amount: "100000",
                                currentPlan: "Garnet",
                                payout: "130000",
                              ))),
                  child: holder(
                    icon: LineIcons.crown,
                    text1: "₦100,000",
                    text2: "Interest 30% ₦130,000",
                    text3: "Garnet",
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StartInvesting(
                                amount: "200000",
                                currentPlan: "Sapphire",
                                payout: "260000",
                              ))),
                  child: holder(
                    icon: LineIcons.biking,
                    text1: "₦200,000",
                    text2: "Interest 30% ₦260,000",
                    text3: "Sapphire",
                    color: Colors.green[900],
                  ),
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChoosePlanB()),
                    ),
                    child: AutoSizeText("Next",
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
   
    );
  }
}
