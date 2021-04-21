import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_dialog/custom_dialog.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:investment_app/models/user_assets.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/provider/user_assets_provider.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class WithdrawMoney extends StatefulWidget {
  final String planType;
  final String amountPaid;
  final String payout;
  final String payoutDate;
  final String uniqueId;

  const WithdrawMoney(
      {Key key, this.planType, this.amountPaid, this.payout, this.payoutDate, this.uniqueId})
      : super(key: key);

  @override
  _WithdrawMoneyState createState() => _WithdrawMoneyState();
}

class _WithdrawMoneyState extends State<WithdrawMoney> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // static const platform = const MethodChannel('TokenChannel');
  // String token;
  bool isLoading = false;
  // _getdeviceToken() async {
  //   await _firebaseMessaging.getToken().then((deviceToken) {
  //     setState(() {
  //       token = deviceToken.toString();
  //     });
  //   });
  // }

  // Future<void> sendData() async {
  //   String message;
  //   try {
  //     message = await platform.invokeMethod(token);
  //     print(message);
  //   } on PlatformException catch (e) {
  //     message = "Failed to get data from native : '${e.message}'.";
  //   }
  // }

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
  void initState() {
    super.initState();

    // _getdeviceToken();
    // sendData();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserData user = userProvider.getUser;
    UserAssetsProvider userAssetsProvider =
        Provider.of<UserAssetsProvider>(context, listen: false);
    UserAssets userAssets = userAssetsProvider.getAssets;
   // print(token);
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
      body: Stack(
        children: [
          isLoading ? Center(child: CircularProgressIndicator()) : SizedBox(),
          Padding(
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
                        subtitle: AutoSizeText(widget.payout.toString(),
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
                    title: AutoSizeText("Plan Type",
                        style: TextStyle(color: Colors.black)),
                    subtitle: AutoSizeText(widget.planType,
                        style: TextStyle(color: Colors.black)),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  ListTile(
                    title: AutoSizeText("Bank Name",
                        style: TextStyle(color: Colors.black)),
                    subtitle: AutoSizeText(user.bankName,
                        style: TextStyle(color: Colors.black)),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  ListTile(
                    title: AutoSizeText("Account Name",
                        style: TextStyle(color: Colors.black)),
                    subtitle: AutoSizeText(user.accountName,
                        style: TextStyle(color: Colors.black)),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  ListTile(
                    title: AutoSizeText("Account Number",
                        style: TextStyle(color: Colors.black)),
                    subtitle: AutoSizeText(user.accountNumber,
                        style: TextStyle(color: Colors.black)),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      DateTime myDateTime = Timestamp.now().toDate();
                      var payoutdate = myDateTime.toString().split(" ");
                      var withdrawDate = payoutdate[0];
                      print(withdrawDate);
                      print(widget.payoutDate);
                      ///TODO: check the values for compatibility
                      if (int.parse(withdrawDate) ==
                              int.parse(widget.payoutDate) ||
                          int.parse(withdrawDate) >
                              int.parse(widget.payoutDate)) {
                        uploadwithdrawdata(
                          uid: user.uid,
                          bankName: user.bankName,
                          accountName: user.accountName,
                          accountNumber: user.accountNumber,
                          name: user.name,
                          assetBalance: userAssets.assetBalance,
                        );
                      }
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
        ],
      ),
    );
  }

  uploadwithdrawdata({
    String uid,
    String bankName,
    String accountNumber,
    String accountName,
    String name,
    int assetBalance,
  }) {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance.collection("WithdrawRequest").doc().set({
      "uid": uid,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "accountName": accountName,
      "amounttoPay": widget.payout,
      "planAmount": widget.amountPaid,
      "planType": widget.planType,
      "username": name,
      "userCurrentAssetBalance": assetBalance,
      "userFCMToken": "token",
      "uniqueId": widget.uniqueId,
    });
    setState(() {
      isLoading = false;
    });
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        content: Text(
          '   Congratulations, your withdrawal was successful, you will receive payments withing 48 hours',
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
  }
}
