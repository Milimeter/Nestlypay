import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:investment_app/models/user_assets.dart';

class AssetMethods{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference _userAssetsCollection =
      firestore.collection("userAssets");

   Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }
  Future<UserAssets> getUserAssetsDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userAssetsCollection.doc(currentUser.uid).get();
    return UserAssets.fromMap(documentSnapshot.data());
  }
}