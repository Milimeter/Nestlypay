import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:investment_app/screens/main_screens/control/start_investing2.dart';
import 'package:investment_app/screens/main_screens/control/top_up_card.dart';
import 'package:investment_app/utils/colors.dart';

class StartInvesting extends StatefulWidget {
  final String amount;
  final String currentPlan;
  final String payout;

  const StartInvesting({Key key, this.amount, this.currentPlan, this.payout})
      : super(key: key);
  @override
  _StartInvestingState createState() => _StartInvestingState();
}

class _StartInvestingState extends State<StartInvesting> {
  TextEditingController _textEditingController = TextEditingController();
  Widget box({String text, Color color}) => Container(
        margin: EdgeInsets.all(10),
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: AutoSizeText(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        )),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/images/logo.png"),
                SizedBox(height: 15),
                Image.asset("assets/images/invest.png", fit: BoxFit.cover),
                SizedBox(height: 10),
                AutoSizeText(
                  "Enter your coupon code",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          "Error!",
                          "Feature not Available Yet",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.white,
                          colorText: Colors.black,
                          duration: Duration(seconds: 5),
                        );
                      },
                      child: Container(
                        child: AutoSizeText("Buy Coupon",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (_textEditingController.text == "12345678" &&
                        _textEditingController.text != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartInvestingTwo()),
                      );
                    } else {
                      Get.snackbar(
                        "Error!",
                        "Input Error",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.white,
                        colorText: Colors.black,
                        duration: Duration(seconds: 5),
                      );
                    }
                  },
                  child: box(
                    color: Colors.blue,
                    text: "Start Investing",
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TopUpCard(
                              amount: widget.amount,
                              currentPlan: widget.currentPlan,
                              payout: widget.payout,
                            )),
                  ),
                  child: box(
                    color: Colors.deepPurple,
                    text: "Pay with Card",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
