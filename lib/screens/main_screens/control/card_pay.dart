// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:investment_app/screens/main_screens/control/pay.dart';
// import 'package:investment_app/screens/main_screens/control/top_up_card.dart';
// import 'package:investment_app/utils/colors.dart';

// class PayWithCard extends StatefulWidget {
//   final String amount;
//   final String currentPlan;
//   final String payout;

//   const PayWithCard({Key key, this.amount, this.currentPlan, this.payout})
//       : super(key: key);

//   @override
//   _PayWithCardState createState() => _PayWithCardState();
// }

// class _PayWithCardState extends State<PayWithCard> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = true;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }

//   Widget box({String text, Color color}) => Container(
//         margin: EdgeInsets.all(10),
//         height: 60,
//         width: MediaQuery.of(context).size.width,
//         decoration:
//             BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
//         child: Center(
//             child: AutoSizeText(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 19,
//           ),
//         )),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: UniversalColors.whiteColor,
//           elevation: 0.0,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )),
//       body: Column(
//         children: [
//           CreditCardWidget(
//             cardNumber: cardNumber,
//             expiryDate: expiryDate,
//             cardHolderName: cardHolderName,
//             cvvCode: cvvCode,
//             showBackView: isCvvFocused,
//             obscureCardNumber: true,
//             obscureCardCvv: false,
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   CreditCardForm(
//                     formKey: formKey,
//                     obscureCvv: true,
//                     obscureNumber: true,
//                     cardNumber: cardNumber,
//                     cvvCode: cvvCode,
//                     cardHolderName: cardHolderName,
//                     expiryDate: expiryDate,
//                     themeColor: Colors.blue,
//                     cardNumberDecoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Number',
//                       hintText: 'XXXX XXXX XXXX XXXX',
//                     ),
//                     expiryDateDecoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Expired Date',
//                       hintText: 'XX/XX',
//                     ),
//                     cvvCodeDecoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'CVV',
//                       hintText: 'XXX',
//                     ),
//                     cardHolderDecoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Card Holder',
//                     ),
//                     onCreditCardModelChange: onCreditCardModelChange,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if (formKey.currentState.validate()) {
//                         print('valid!');
//                       } else {
//                         print('invalid!');
//                       }
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => PaymentPage(
//                                   amount: widget.amount,
//                                   currentPlan: widget.currentPlan,
//                                   payout: widget.payout,
//                                 )),
//                       );
//                     },
//                     child: box(
//                       color: Colors.blue,
//                       text: "Pay ₦${widget.amount}",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
