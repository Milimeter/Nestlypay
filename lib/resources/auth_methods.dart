import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:investment_app/models/users.dart';

class AuthMethods {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection("users");

  Future<String> signIn(String email, String password) async {
    print('===========>' + email);
    User user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    User user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    return currentUser;
  }

  Future<void> sendEmailVerification() async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    currentUser.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    return currentUser.emailVerified;
  }

  Future<void> changeEmail(String email) async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    currentUser.updateEmail(email).then((_) {
      print("Succesfull changed email");
    }).catchError((error) {
      print("email can't be changed" + error.toString());
    });
    return null;
  }

  Future<void> changePassword(String password) async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    currentUser.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  Future<void> deleteUser() async {
    User currentUser;
    currentUser = _firebaseAuth.currentUser;
    currentUser.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  Future<void> sendPasswordResetMail(String email) async {
    print('===========>' + email);
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

  Future<UserData> getUserDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
        await _userCollection.doc(currentUser.uid).get();
    return UserData.fromMap(documentSnapshot.data());
  }

  Future<void> addDataToDb(
      {User currentUser, username, password, token, phone}) async {
    UserData user = UserData(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      password: password,
      //profilePhoto: currentUser.photoUrl,
      username: username,
    );
    //user details
    firestore
        .collection("users")
        .doc(currentUser.uid)
        .set(user.toMap(user));
  }
}
