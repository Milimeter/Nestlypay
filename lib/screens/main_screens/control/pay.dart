import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:investment_app/provider/user_assets_provider.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/resources/payment_methods.dart';
import 'package:provider/provider.dart';
import 'package:rave_flutter/rave_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String amount;
  final String currentPlan;
  final String payout;

  const PaymentPage({Key key, this.amount, this.currentPlan, this.payout})
      : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  UserProvider userProvider;
  UserAssetsProvider userAssetsProvider;
  int paidDate = DateTime.now().microsecondsSinceEpoch;
  int payoutDate =
      DateTime.now().add(Duration(days: 31)).microsecondsSinceEpoch;
  PaymentMethods paymentMethods = PaymentMethods();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var autoValidate = false;
  bool acceptCardPayment = true;
  bool acceptAccountPayment = true;
  bool acceptMpesaPayment = false;
  bool shouldDisplayFee = true;
  bool acceptAchPayments = false;
  bool acceptGhMMPayments = false;
  bool acceptUgMMPayments = false;
  bool acceptMMFrancophonePayments = false;
  bool live = false;
  bool preAuthCharge = false;
  bool addSubAccounts = false;
  List<SubAccount> subAccounts = [];
  String publicKey = "FLWPUBK-1b4cee87cfe7d211d207c9a93c09a11a-X";
  String encryptionKey = "eff9e6b0e81de400406d13b7";
  String txRef = "NestlyPay-${DateTime.now().toString()}";
  String orderRef = "NestlyPay-${DateTime.now().toString()}";
  String narration = "Investing on NestlyPay";

  String firstName;
  String lastName;

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userAssetsProvider =
        Provider.of<UserAssetsProvider>(context, listen: false);
    super.initState();
  }

  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.30,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.60,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(15),
                height: 50,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                margin: EdgeInsets.only(top: 40, left: 30),
                child: Icon(Icons.arrow_back, color: Colors.blue[800]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 200,
                      width: size.width,
                      margin: EdgeInsets.only(top: size.height * 0.30),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(4, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                "Amount",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              AutoSizeText(
                                "₦${widget.amount}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                "Free",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              AutoSizeText(
                                "+ 50",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                "Amount",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              AutoSizeText(
                                "₦${widget.amount}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "Ensure you have a stable internet connection",
                              style: TextStyle(color: Colors.grey),
                            ),
                            AutoSizeText(
                              "You can exit the screen in $_start",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: () =>
                          startPayment(amount: double.tryParse(widget.amount)),
                      child: Container(
                        height: 60,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Center(
                          child: AutoSizeText("Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startPayment({double amount}) async {
    var name = userProvider.getUser.name.split(' ');
    var firstName = name[0] ?? "";
    var lastName = name[1] ?? "";
    print(firstName);
    print(lastName);
    var initializer = RavePayInitializer(
        amount: amount,
        publicKey: publicKey,
        encryptionKey: encryptionKey,
        subAccounts: subAccounts.isEmpty ? null : null)
      ..country = "NG"
      ..currency = "NGN"
      ..email = userProvider.getUser.email
      ..fName = firstName
      ..lName = lastName
      ..narration = narration ?? ''
      ..txRef = txRef
      ..acceptMpesaPayments = acceptMpesaPayment
      ..acceptAccountPayments = acceptAccountPayment
      ..acceptCardPayments = acceptCardPayment
      ..acceptAchPayments = acceptAchPayments
      ..acceptGHMobileMoneyPayments = acceptGhMMPayments
      ..acceptUgMobileMoneyPayments = acceptUgMMPayments
      ..acceptMobileMoneyFrancophoneAfricaPayments = acceptMMFrancophonePayments
      ..displayEmail = true
      ..displayAmount = true
      ..staging = false
      ..isPreAuth = preAuthCharge
      ..displayFee = shouldDisplayFee
      ..companyName = Text("NestlyPay");

    RaveResult response = await RavePayManager()
        .prompt(context: context, initializer: initializer);
    print(response);
    if (response != null) {
      print(
          "-------------------------response not null-----------------------");
      print(response?.message);
      if (response.status == RaveStatus.success) {
        startTimer();
        print(response?.message);
        print("--------------------SuccessFul Payment----------------------");
        await paymentMethods.addPaymentDetailsToUserDatabase(
          amountPaid: int.parse(widget.amount),
          currentPlan: widget.currentPlan,
          paidDate: paidDate,
          payoutDate: payoutDate,
          payout: int.parse(widget.payout),
        );
        print(
            "--------------------Updated addPaymentDetailsToUserDatabase()---------------------------");
        int userAssetBalance = userAssetsProvider.getAssets.assetBalance +
            int.parse(widget.amount);

        FirebaseFirestore.instance
            .collection("AppRevenue")
            .doc()
            .get()
            .then((value) {
          if (value.exists) {
            int currentAppRevenue = value.data()["appRevenue"];
            int appRevenue = currentAppRevenue + int.parse(widget.amount);
            FirebaseFirestore.instance
                .collection("AppRevenue")
                .doc()
                .update({"appRevenue": appRevenue});
          }
        });
        await paymentMethods.updateUserAssets(
          planType: widget.currentPlan,
          userAssetBalance: userAssetBalance,
        );
        print(
            "========================Updated user Assets and balance==================");
        //await userAssetsProvider.refreshAssets();
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          await userAssetsProvider.refreshAssets();
        });

        print(
            "-------------------New asset balance is ${userAssetsProvider.getAssets.assetBalance}-------------");
        Get.snackbar(
          "NestlyPay!",
          "${response?.message}. Please wait a couple of seconds before leaving this page",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          duration: Duration(seconds: 5),
        );
        // CustomDialog(
        //   content: Text(
        //     'Invested',
        //     style: TextStyle(
        //       fontWeight: FontWeight.w900,
        //       fontSize: 20.0,
        //     ),
        //   ),
        //   title: Text('Payment successful'),
        //   firstColor: Colors.blue[900],
        //   secondColor: Colors.white,
        //   headerIcon: Icon(
        //     Icons.error_outline,
        //     size: 120.0,
        //     color: Colors.white,
        //   ),
        // );
      } else if (response.status == RaveStatus.cancelled) {
        Get.snackbar(
          "NestlyPay!",
          response?.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          duration: Duration(seconds: 5),
        );
      } else if (response.status == RaveStatus.error) {
        Get.snackbar(
          "NestlyPay!",
          response?.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          duration: Duration(seconds: 5),
        );
      }
    } else {
      Get.snackbar(
        "Error!",
        "No Response",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        duration: Duration(seconds: 5),
      );
    }

    // scaffoldKey.currentState
    //     .showSnackBar(SnackBar(content: Text(response?.message)));
  }
}
