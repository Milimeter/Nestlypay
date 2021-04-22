// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:investment_app/screens/main_screens/control/referrals.dart';
// import 'package:investment_app/utils/colors.dart';

// class SendMoney extends StatefulWidget {
//   @override
//   _SendMoneyState createState() => _SendMoneyState();
// }

// class _SendMoneyState extends State<SendMoney> {
//   // Variables
//   Size _screenSize;
//   int _currentDigit;
//   int _firstDigit;
//   int _secondDigit;
//   int _thirdDigit;
//   int _fourthDigit;
//   int _fifthDigit;
//   int _sixthDigit;
//   bool otpCompleted = false;
//   String enteredOTP;

//   // Return "OTP" input field
//   get _getInputField {
//     return Container(
//       height: 80,
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.blue, width: 2),
//           borderRadius: BorderRadius.circular(16)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           AutoSizeText("N ",
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontStyle: FontStyle.italic,
//               )),
//           _otpTextField(_firstDigit),

//           _otpTextField(_secondDigit),
//           _otpTextField(_thirdDigit),
//           _otpTextField(_fourthDigit),
//           _otpTextField(_fifthDigit),
//           _otpTextField(_sixthDigit),
//           //adding two more
//         ],
//       ),
//     );
//   }

//   // Returns "OTP" input part
//   get _getInputPart {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         // _getEmailLabel,
//         _getInputField,
//         //SizedBox(height: 10),
//         //_hideResendButton ? _getTimerText : _getResendButton,
//         SizedBox(height: 40),
//         _getOtpKeyboard
//       ],
//     );
//   }

//   get _getOtpKeyboard {
//     return Container(
//         height: _screenSize.width - 130,
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   _otpKeyboardInputButton(
//                       label: "1",
//                       onPressed: () {
//                         _setCurrentDigit(1);
//                       }),
//                   _otpKeyboardInputButton(
//                       label: "2",
//                       onPressed: () {
//                         _setCurrentDigit(2);
//                       }),
//                   _otpKeyboardInputButton(
//                       label: "3",
//                       onPressed: () {
//                         _setCurrentDigit(3);
//                       }),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   _otpKeyboardInputButton(
//                       label: "4",
//                       onPressed: () {
//                         _setCurrentDigit(4);
//                       }),
//                   _otpKeyboardInputButton(
//                       label: "5",
//                       onPressed: () {
//                         _setCurrentDigit(5);
//                       }),
//                   _otpKeyboardInputButton(
//                       label: "6",
//                       onPressed: () {
//                         _setCurrentDigit(6);
//                       }),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   _otpKeyboardInputButton(
//                       label: "7",
//                       onPressed: () {
//                         _setCurrentDigit(7);
//                       }),
//                   _otpKeyboardInputButton(
//                       label: "8",
//                       onPressed: () {
//                         _setCurrentDigit(8);
//                       }),
//                   _otpKeyboardInputButton(
//                       label: "9",
//                       onPressed: () {
//                         _setCurrentDigit(9);
//                       }),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   _otpKeyboardInputButton(
//                       label: "0",
//                       onPressed: () {
//                         _setCurrentDigit(0);
//                       }),
//                   _otpKeyboardInputButton(
//                       label: ".",
//                       onPressed: () {
//                         _setCurrentDigit(".");
//                       }),
//                   // _otpKeyboardActionButton(
//                   //     label: Icon(
//                   //       Icons.send,
//                   //       size: 30,
//                   //       color: Theme.of(context).primaryColor,
//                   //     ),
//                   //     onPressed: () {}),

//                   _otpKeyboardActionButton(
//                       label:
//                           Icon(Icons.backspace, size: 30, color: Colors.grey),
//                       onPressed: () {
//                         setState(() {
//                           if (_sixthDigit != null) {
//                             _sixthDigit = null;
//                           } else if (_fifthDigit != null) {
//                             _fifthDigit = null;
//                           } else if (_fourthDigit != null) {
//                             _fourthDigit = null;
//                           } else if (_thirdDigit != null) {
//                             _thirdDigit = null;
//                           } else if (_secondDigit != null) {
//                             _secondDigit = null;
//                           } else if (_firstDigit != null) {
//                             _firstDigit = null;
//                           }
//                         });
//                       }),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }

//   Widget proceed() => Container(
//         height: 48,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             color: Colors.blue, borderRadius: BorderRadius.circular(14)),
//         child: Center(
//             child: AutoSizeText(
//           "Proceed",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//           ),
//         )),
//       );

//   @override
//   Widget build(BuildContext context) {
//     _screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         centerTitle: true,
//         backgroundColor: UniversalColors.whiteColor,
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context)),
//         title: AutoSizeText(
//           "Send Money",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Container(
//           padding: EdgeInsets.only(top: 20.0),
//           child: SingleChildScrollView(
//             child: Column(children: [
//               Row(children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage("assets/images/picb.png"),
//                   backgroundColor: Colors.white,
//                   radius: 30,
//                 ),
//                 Expanded(
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 12.0),
//                           child: AutoSizeText(
//                             "To",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                         ListTile(
//                           title: AutoSizeText(
//                             "Admin",
//                             style: TextStyle(
//                                 fontSize: 19,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: AutoSizeText(
//                             "dolores.chambers@example.com",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         )
//                       ]),
//                 )
//               ]),
//               Container(
//                 width: _screenSize.width,
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: _getInputPart,
//               ),
//               SizedBox(height: 18),
//               GestureDetector(
//                   onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ReferralPage()),
//                       ),
//                   child: proceed())
//             ]),
//           ),
//         ),
//       ),
//     );
//   }

//   // Returns "Otp custom text field"
//   Widget _otpTextField(dynamic digit) {
//     return Container(
//       width: 35.0,
//       height: 45.0,
//       alignment: Alignment.center,
//       child: Text(
//         digit != null ? digit.toString() : "",
//         style: TextStyle(
//           fontSize: 30.0,
//           // color: Theme.of(context).primaryColor,
//           color: Colors.black,
//         ),
//       ),
//       decoration: BoxDecoration(
// //            color: Colors.grey.withOpacity(0.4),
//           border: Border(
//               bottom: BorderSide(
//         width: 5.0,
//         //color: Theme.of(context).primaryColor,
//         color: Colors.transparent,
//       ))),
//     );
//   }

//   // Returns "Otp keyboard input Button"
//   Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(40.0),
//         child: Container(
//           height: 80.0,
//           width: 80.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.w800,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Returns "Otp keyboard action Button"
//   _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       borderRadius: BorderRadius.circular(40.0),
//       child: Container(
//         height: 80.0,
//         width: 80.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//         ),
//         child: Center(
//           child: label,
//         ),
//       ),
//     );
//   }

//   // Current digit
//   void _setCurrentDigit(i) {
//     setState(() {
//       _currentDigit = i;
//       if (_firstDigit == null) {
//         _firstDigit = _currentDigit;
//       } else if (_secondDigit == null) {
//         _secondDigit = _currentDigit;
//       } else if (_thirdDigit == null) {
//         _thirdDigit = _currentDigit;
//       } else if (_fourthDigit == null) {
//         _fourthDigit = _currentDigit;
//       } else if (_fifthDigit == null) {
//         _fifthDigit = _currentDigit;
//       } else if (_sixthDigit == null) {
//         _sixthDigit = _currentDigit;

//         // Verify your otp by here. API call
//         // the otp is 6 add two more

//       }
//     });
//     enteredOTP = _firstDigit.toString() +
//         _secondDigit.toString() +
//         _thirdDigit.toString() +
//         _fourthDigit.toString() +
//         _fifthDigit.toString() +
//         _sixthDigit.toString();

//     print("otp is " + enteredOTP);
//     if (enteredOTP.length == 6) {
//       setState(() {
//         otpCompleted = true;
//       });
//       print("signIn called ==============>>>>");
//       // signIn(enteredOTP);

//       //otp = enteredOTP;
//     } else if (enteredOTP.length != 6) {
//       setState(() {
//         otpCompleted = false;
//       });
//     }

//     //signIn(enteredOTP);
//   }
// }
