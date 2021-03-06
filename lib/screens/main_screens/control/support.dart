import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  void _launchURL({String email}) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  launchSupportURL({String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Image.asset("assets/images/logo.png"),
            SizedBox(height: 10),
            Image.asset("assets/images/support.png"),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText("Reach our support team",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ListTile(
                      //   leading: Icon(Icons.mail, color: Colors.blue),
                      //   title: AutoSizeText(
                      //     "(480) 555-0103",
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        onTap: () =>
                            _launchURL(email: "Customercare@nestlypay.com"),
                        leading: Icon(Icons.mail, color: Colors.blue),
                        title: AutoSizeText(
                          "Customercare@nestlypay.com",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () =>
                            _launchURL(email: "Technicalservice@nestlypay.com"),
                        leading: Icon(Icons.mail, color: Colors.blue),
                        title: AutoSizeText(
                          "Technicalservice@nestlypay.com",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () => _launchURL(email: "info@nestlypay.com"),
                        leading: Icon(Icons.mail, color: Colors.blue),
                        title: AutoSizeText(
                          "info@nestlypay.com",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText("Reach us on social media",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () => launchSupportURL(
                              url: "https://twitter.com/nestlypay"),
                          child: Image.asset("assets/images/twitter.png")),
                      GestureDetector(
                          onTap: () => launchSupportURL(
                              url: "https://instagram.com/nestlypay"),
                          child: Image.asset("assets/images/instagram.png")),
                      // Image.asset("assets/images/whatsapp.png"),
                    ],
                  )),
            ),
          ],
        ))),
      ),
    );
  }
}
