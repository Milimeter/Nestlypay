import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/provider/user_provider.dart';
import 'package:investment_app/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class People extends StatefulWidget {
  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  Map<String, double> data = new Map();
  @override
  void initState() {
    data.addAll({
      'Money Savings': 37136,
      'Expenses': 69687,
      'Transfer': 40609,
      'Fees': 42544
    });
    super.initState();
  }

  List<Color> _colors = [
    Colors.teal,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.redAccent
  ];
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserData user = userProvider.getUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: UniversalColors.blueColor,
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
      body: user.isAdmin != null && user.isAdmin == true
          ? Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: AutoSizeText(
                        "Data Analytics",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      subtitle: AutoSizeText(
                        "Saving",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(17),
                        decoration: BoxDecoration(
                            color: Colors.green[700],
                            borderRadius: BorderRadius.circular(13)),
                        child: Icon(
                          Icons.connect_without_contact_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    PieChart(
                      dataMap: data,
                      colorList:
                          _colors, // if not declared, random colors will be chosen
                      animationDuration: Duration(milliseconds: 1500),
                      chartLegendSpacing: 32.0,
                      chartRadius: MediaQuery.of(context).size.width /
                          2.7, //determines the size of the chart
                      showChartValuesInPercentage: true,
                      showChartValues: true,
                      showChartValuesOutside: false,
                      chartValueBackgroundColor: Colors.grey[200],
                      showLegends: true,
                      legendPosition: LegendPosition
                          .right, //can be changed to top, left, bottom
                      decimalPlaces: 1,
                      showChartValueLabel: true,
                      initialAngle: 0,
                      chartValueStyle: defaultChartValueStyle.copyWith(
                        color: Colors.blueGrey[900].withOpacity(0.9),
                      ),
                      chartType:
                          ChartType.disc, //can be changed to ChartType.ring
                    ),
                    SizedBox(height: 15),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.teal,
                            ),
                            child: Text(""),
                          ),
                          SizedBox(width: 9),
                          AutoSizeText(
                            "Money Saving",
                            style: TextStyle(
                              color: Colors.black,
                              //fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: AutoSizeText(
                        "€18,409",
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.teal,
                            ),
                            child: Text(""),
                          ),
                          SizedBox(width: 9),
                          AutoSizeText(
                            "Expenses",
                            style: TextStyle(
                              color: Colors.black,
                              //fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: AutoSizeText(
                        "€1,409",
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.teal,
                            ),
                            child: Text(""),
                          ),
                          SizedBox(width: 9),
                          AutoSizeText(
                            "Transfer",
                            style: TextStyle(
                              color: Colors.black,
                              //fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: AutoSizeText(
                        "€65,955",
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: Colors.teal,
                            ),
                            child: Text(""),
                          ),
                          SizedBox(width: 9),
                          AutoSizeText(
                            "Fees",
                            style: TextStyle(
                              color: Colors.black,
                              //fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: AutoSizeText(
                        "€652",
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 2000,
                          footer: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: AutoSizeText("11220 Total"),
                          ),
                          center: Icon(Icons.star, color: Colors.blue),
                          radius: 90.0,
                          lineWidth: 4.0,
                          percent: 0.50,
                          //center: Text("30%"),
                          progressColor: Colors.blue,
                        ),
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1500,
                          footer: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: AutoSizeText("70 Online"),
                          ),
                          center: Icon(Icons.map, color: Colors.blue[800]),
                          radius: 90.0,
                          lineWidth: 4.0,
                          percent: 0.70,
                          //center: Text("30%"),
                          progressColor: Colors.blue[800],
                        ),
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1300,
                          footer: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: AutoSizeText("5000 Active"),
                          ),
                          center: Icon(Icons.flag_rounded, color: Colors.green),
                          radius: 90.0,
                          lineWidth: 4.0,
                          percent: 0.20,
                          //center: Text("30%"),
                          progressColor: Colors.green,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Container(
              child: Center(
                child: AutoSizeText("Feature Coming Soon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
            ),
    );
  }
}
