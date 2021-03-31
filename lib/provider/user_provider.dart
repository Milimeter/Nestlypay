import 'package:flutter/material.dart';
import 'package:investment_app/models/users.dart';
import 'package:investment_app/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserData _user;
  AuthMethods _authMethods = AuthMethods();

  UserData get getUser => _user;

  Future<void> refreshUser() async {
    UserData user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
