import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';

class WithdrawMoney extends StatefulWidget {
  @override
  _WithdrawMoneyState createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
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
        padding: const EdgeInsets.all(10.0),
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/logo.png", fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: AutoSizeText("Amount",
                        style: TextStyle(color: Colors.blueGrey)),
                    subtitle: AutoSizeText("200,000",
                        style: TextStyle(color: Colors.blueGrey)),
                    trailing: Icon(
                      Icons.arrow_downward_sharp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              ListTile(
                title: AutoSizeText("Bank Name",
                    style: TextStyle(color: Colors.black)),
                subtitle:
                    AutoSizeText("UBA", style: TextStyle(color: Colors.black)),
              ),
              Divider(),
              SizedBox(height: 20),
              ListTile(
                title: AutoSizeText("Account Name",
                    style: TextStyle(color: Colors.black)),
                subtitle: AutoSizeText("Charles",
                    style: TextStyle(color: Colors.black)),
              ),
              Divider(),
              SizedBox(height: 20),
              ListTile(
                title: AutoSizeText("Account Number",
                    style: TextStyle(color: Colors.black)),
                subtitle: AutoSizeText("212123444",
                    style: TextStyle(color: Colors.black)),
              ),
              Divider(),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      content: Text(
                        '   Congratulations, your withdrawal was successful, you will receive payments withing 24 hours',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          
                          //fontSize: 20.0,
                        ),
                      ),
                      title: Text('Yeay Successful'),
                      firstColor: Colors.green,
                      secondColor: Colors.white,
                      headerIcon: Icon(
                        LineIcons.moneyBill,
                        size: 120.0,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                child: box(
                  color: Colors.blue,
                  text: "Withdraw",
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
