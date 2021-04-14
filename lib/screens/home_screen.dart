import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:investment_app/provider/user_assets_provider.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/screens/main_screens/pageview/home.dart';
import 'package:investment_app/screens/main_screens/pageview/people.dart';
import 'package:investment_app/screens/main_screens/pageview/settings.dart';
import 'package:investment_app/screens/main_screens/pageview/wallet.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  UserProvider userProvider;
  UserAssetsProvider userAssetsProvider; 

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    People(),
    WalletPage(),
    Settings(),
  ];
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userAssetsProvider =
          Provider.of<UserAssetsProvider>(context, listen: false);
      await userProvider.refreshUser();
      await userAssetsProvider.refreshAssets();
    });
    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     print("aaaaaaaaa");
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 20,
      //   title: const Text('GoogleNavBar'),
      // ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Colors.blue,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.people,
                    text: 'Accounts',
                  ),
                  GButton(
                    icon: LineIcons.wallet,
                    text: 'Wallet',
                  ),
                  GButton(
                    icon: LineIcons.cog,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
