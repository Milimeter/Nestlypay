import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/resources/auth_methods.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:provider/provider.dart';

class BankInfo extends StatefulWidget {
  @override
  _BankInfoState createState() => _BankInfoState();
}

class _BankInfoState extends State<BankInfo> {
  TextEditingController _bankNametextEditingController =
      TextEditingController();
  TextEditingController _accountNametextEditingController =
      TextEditingController();
  TextEditingController _accountNotextEditingController =
      TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthMethods authMethods = AuthMethods();
  bool _validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  _validateAndSubmit(provider) async {
    print("auth started");
    if (_validateAndSave()) {
      setState(() {
        isLoading = true;
      });

      try {
        User currentUser;
        currentUser = _auth.currentUser;

        print("auth started2");

        //FirebaseUser user = await _auth.currentUser;
        print("updating data");
        await authMethods.updateBankDataInDb(
          currentUser: currentUser,
          bankName: _bankNametextEditingController.text.trim(),
          accountName: _accountNametextEditingController.text.trim(),
          accountNumber: _accountNotextEditingController.text.trim(),
        );
        print("updated data");
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          await provider.refreshUser();
        });

        String userId = currentUser.uid;
        print('Signed up user: $userId');

        Navigator.pop(context);
      } catch (e) {
        print('Error: $e');
        setState(() {
          isLoading = false;
        });
        Get.snackbar(
          "Error!",
          "${e.toString()}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
      }
    } else {
      Get.snackbar(
        "Error!",
        "Unknown Error, try again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

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
    UserProvider userProvider = Provider.of(context, listen: false);
    UserData user = userProvider.getUser;
    _bankNametextEditingController.text = user.bankName ?? _bankNametextEditingController.text;
    _accountNametextEditingController.text = user.accountName ?? _accountNametextEditingController.text;
    _accountNotextEditingController.text = user.accountNumber ?? _accountNotextEditingController.text;
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
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Container(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  Image.asset("assets/images/logo.png"),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText("Bank Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25)),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (String value) {
                        return value.isEmpty
                            ? "Bank Name can't be empty"
                            : null;
                      },
                      controller: _bankNametextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.home),
                        hintText: "Bank Name e.g UBA",
                        border: UnderlineInputBorder(),
                      )),
                  SizedBox(height: 25),
                  TextFormField(
                      validator: (String value) {
                        return value.isEmpty
                            ? "Account Name can't be empty"
                            : null;
                      },
                      textCapitalization: TextCapitalization.words,
                      controller: _accountNametextEditingController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.perm_contact_cal),
                        hintText: "Account Name",
                        border: UnderlineInputBorder(),
                      )),
                  SizedBox(height: 25),
                  TextFormField(
                      validator: (String value) {
                        if (value.length != 10 ) {
                          return " Account number length should be 10";
                        } else {
                          return null;
                        }
                      },
                      controller: _accountNotextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.power_input),
                        hintText: "Account Number",
                        border: UnderlineInputBorder(),
                      )),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => _validateAndSubmit(userProvider),
                    child: box(
                      color: Colors.blue,
                      text: "Save",
                    ),
                  ),
                ],
              ))),
            ),
          ),
        ],
      ),
    
    );
  }
}
