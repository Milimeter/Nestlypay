import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/resources/auth_methods.dart';
import 'package:investment_app/screens/auth/login_screen.dart';
import 'package:investment_app/screens/main_screens/control/bank_info.dart';
import 'package:investment_app/screens/main_screens/control/personal_info.dart';
import 'package:investment_app/screens/main_screens/control/referrals.dart';
import 'package:investment_app/screens/main_screens/control/support.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthMethods authMethods = AuthMethods();
  Widget profileContainer(String name) => Container(
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            color: Colors.blue[800], borderRadius: BorderRadius.circular(35)),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/picb.png"),
              backgroundColor: Colors.white,
              radius: 30,
            ),
            title: AutoSizeText(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            subtitle: AutoSizeText(
              "Platinum plan \n\nCashout date 5/07/2021",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: AutoSizeText(
                "Edit",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );

  Widget listCard({String title, IconData icon, Function onTap}) => Card(
      elevation: 5.0,
      shadowColor: Colors.grey,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.black),
        title: AutoSizeText(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
        ),
      ));
  personalInfo() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => PersonalInfo()));
  bankInfo() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => BankInfo()));
  supportPage() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => SupportPage()));
  referralPage() => Navigator.push(
      context, MaterialPageRoute(builder: (context) => ReferralPage()));
  loginScreen() {
    authMethods.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
   
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserData user = userProvider.getUser;
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
        title: AutoSizeText("27 March 2021",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(18),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                profileContainer(user.name),
                SizedBox(height: 25),
                listCard(
                  icon: Icons.inbox,
                  title: "Personal Info",
                  onTap: personalInfo,
                ),
                listCard(icon: LineIcons.wallet, title: "Investment Wallet"),
                SizedBox(height: 20),
                listCard(
                  icon: Icons.house,
                  title: "Bank Account Info",
                  onTap: bankInfo,
                ),
                SizedBox(height: 20),
                listCard(
                  icon: Icons.book,
                  title: "Support",
                  onTap: supportPage,
                ),
                SizedBox(height: 20),
                listCard(
                  icon: LineIcons.cog,
                  title: "Referral",
                  onTap: referralPage,
                ),
                SizedBox(height: 20),
                listCard(
                  icon: Icons.exit_to_app,
                  title: "Logout",
                  onTap: loginScreen,
                )
              ]))),
    );
  }
}
