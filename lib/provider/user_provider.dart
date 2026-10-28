import 'package:flutter/material.dart';
import 'package:yahya_project/models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  ///Declare Var
  UserModel _userModel = UserModel();

  ///set User
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  ///get User
  UserModel getUser() => _userModel;
}