import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:investment_app/provider/user_assets_provider.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/resources/payment_methods.dart';
import 'package:provider/provider.dart';

class TopUpCard extends StatefulWidget {
  final String amount;
  final String currentPlan;
  final String payout;

  const TopUpCard({Key key, this.amount, this.currentPlan, this.payout})
      : super(key: key);

  @override
  _TopUpCardState createState() => _TopUpCardState();
}

class _TopUpCardState extends State<TopUpCard> {
  UserProvider userProvider;
  UserAssetsProvider userAssetsProvider;
  final formKey = GlobalKey<FormState>();
  final String txref = "My_unique_transaction_reference_123";
  final String currency = FlutterwaveCurrency.NGN;
  int paidDate = DateTime.now().microsecondsSinceEpoch;
  int payoutDate =
      DateTime.now().add(Duration(days: 31)).microsecondsSinceEpoch;
  PaymentMethods paymentMethods = PaymentMethods();

  _onPressed() {
    this._handlePaymentInitialization();
  }

  _handlePaymentInitialization() async {
    final flutterwave = Flutterwave.forUIPayment(
        amount: widget.amount,
        currency: currency,
        context: this.context,
        publicKey: "FLWPUBK-7b4729c39cb67716ee85122931ed9394-X",
        encryptionKey: "6b8fb80365e2e4471b619752",
        email: userProvider.getUser.email.toString(),
        fullName: userProvider.getUser.name.toString(),
        //txRef: DateTime.now().toIso8601String(),
        txRef: txref,
        narration: "Example Payment Project",
        isDebugMode: true,
        phoneNumber: userProvider.getUser.phoneNo.toString(),
        acceptAccountPayment: true,
        acceptCardPayment: true,
        acceptUSSDPayment: true);
    final response = await flutterwave.initializeForUiPayments();
    if (response != null) {
      final isSuccessful = checkPaymentIsSuccessful(response);
      if (isSuccessful) {
        print(response.message);
        print("SuccessFul Payment");
        await paymentMethods.addPaymentDetailsToUserDatabase(
          amountPaid: int.parse(widget.amount),
          currentPlan: widget.currentPlan,
          paidDate: paidDate,
          payoutDate: payoutDate,
          payout: int.parse(widget.payout),
        );
        print("Updated addPaymentDetailsToUserDatabase()");
        int userAssetBalance = userAssetsProvider.getAssets.assetBalance +
            int.parse(widget.amount);
        await paymentMethods.updateUserAssets(
            planType: widget.currentPlan, userAssetBalance: userAssetBalance);
        print("Updated user Assets and balance");
        await userAssetsProvider.refreshAssets();
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          await userAssetsProvider.refreshAssets();
        });

        print(
            "New asset balance is ${userAssetsProvider.getAssets.assetBalance}");
        return CustomDialog(
          content: Text(
            'Invested',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
          title: Text('Payment successful'),
          firstColor: Colors.green,
          secondColor: Colors.white,
          headerIcon: Icon(
            Icons.error_outline,
            size: 120.0,
            color: Colors.white,
          ),
        );

        // provide value to customer
      } else {
        // check message
        print(response.message);
        print("UnsuccessFul Payment");
        // check status
        print(response.status);

        // check processor error
        print(response.data.processorResponse);
        return CustomDialog(
          content: Text(
            'No Access',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
          title: Text('Payment Unsuccessful'),
          firstColor: Colors.red,
          secondColor: Colors.white,
          headerIcon: Icon(
            Icons.error_outline,
            size: 120.0,
            color: Colors.white,
          ),
        );
      }
      // print(response.data.status);
      // this.showLoading(response.data.status);
    } else {
      this.showLoading("No Response!");
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == currency &&
        response.data.amount == widget.amount &&
        response.data.txRef == txref;
  }

  showLoading(String message) {
    return CustomDialog(
      content: Text(
        'No Access',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20.0,
        ),
      ),
      title: Text(message),
      firstColor: Colors.red,
      secondColor: Colors.white,
      headerIcon: Icon(
        Icons.error_outline,
        size: 120.0,
        color: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userAssetsProvider =
        Provider.of<UserAssetsProvider>(context, listen: false);
    super.initState();
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
                        child: AutoSizeText(
                          "Ensure you have a stable internet connection",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: () => _onPressed(),
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
}
