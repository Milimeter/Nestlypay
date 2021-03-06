import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:investment_app/models/user_packages.dart';
import 'package:investment_app/models/user_payments.dart';

class PaymentMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  Future<void> addPaymentDetailsToUserDatabase({
    int amountPaid,
    int paidDate,
    String currentPlan,
    int payout,
    int payoutDate,
    String uniqueId,
  }) async {
    User currentUser = await getCurrentUser();
    UserPayments userPayments = UserPayments(
      uid: currentUser.uid,
      amountPaid: amountPaid,
      paidDate: paidDate,
      currentPlan: currentPlan,
      payout: payout,
      payoutDate: payoutDate,
      visiblePaidDate: DateTime.now(),
      visiblePayoutDate: DateTime.now().add(Duration(days: 31)),
      uniqueId: uniqueId,
    ); 
    //set user packages
    UserPackages userPackages = UserPackages(
      uid: currentUser.uid,
      amountPaid: amountPaid,
      paidDate: paidDate,
      currentPlan: currentPlan,
      payout: payout,
      payoutDate: payoutDate,
      visiblePaidDate: DateTime.now(),
      visiblePayoutDate: DateTime.now().add(Duration(days: 31)), 
      timeStamp: DateTime.now(),
      uniqueId: uniqueId,
    );
    firestore
        .collection("userPayments") 
        .doc()
        .set(userPayments.toMap(userPayments));

    firestore
        .collection("userPackages")
        .doc(uniqueId)
        .set(userPackages.toMap(userPackages));
  }

  Future<void> updateUserAssets({String planType, int userAssetBalance}) async {
    User currentUser = await getCurrentUser();
    FirebaseFirestore.instance
        .collection("userAssets")
        .doc(currentUser.uid)
        .update({
      "currentPlans": FieldValue.arrayUnion([planType]),
      "assetBalance": userAssetBalance,
    });

    // FirebaseFirestore.instance.collection("userAssets").doc().update({
    //       "assetBalance": userAssetBalance,
    //     });
  }

  // Future<void> setUserLoggedInState(){
  //   FirebaseFirestore.instance.collection("userState").doc("uid").update({
  //     "loggedIn": true,
  //   });
  // }

  // login()async{
  //   // after login in
  //  var state = await checkIfUserIsLoggedIn("uid");
  //   if( state){
  //     signout();
  //   }
  //   else{
  //     goToHomeScreen();
  //   }

  // }

  // Future<bool> checkIfUserIsLoggedIn(uid){

  //   FirebaseFirestore.instance.collection("userState").doc(uid).get().then((value) {
  //     if(value.exists){
  //       bool loggedInState = value.data()["loggedIn"] == true;
  //      return loggedInState ;
  //     }
  //   });

  // }

}
