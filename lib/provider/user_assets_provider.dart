import 'package:flutter/material.dart';
import 'package:investment_app/models/user_assets.dart';
import 'package:investment_app/resources/assets_methods.dart';



class UserAssetsProvider with ChangeNotifier {
  UserAssets _user;
  AssetMethods _assetMethods = AssetMethods();

  UserAssets get getAssets => _user;

  Future<void> refreshAssets() async {
    UserAssets user = await _assetMethods.getUserAssetsDetails();
    _user = user;
    notifyListeners();
  }
}
