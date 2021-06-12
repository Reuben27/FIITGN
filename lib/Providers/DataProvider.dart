import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Data_Provider with ChangeNotifier {
  static String _uid;
  // String _auth_token;
  static String _emailId;
  static String _name;
  static String _userDisplay;

// getters
  // void setToken(String token) {
  //   _auth_token = token;
  //   notifyListeners();
  // }

  void setUid(String userUid) {
    _uid = userUid;
    notifyListeners();
  }

  void setEmailId(String email) {
    _emailId = email;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setDisplay(String url) {
    _userDisplay = url;
    notifyListeners();
  }

// getters
  String get name {
    return _name;
  }

  // String get auth_token {
  //   return _auth_token;
  // }

  String get uid {
    return _uid;
  }

  String get email {
    return _emailId;
  }

  String get user_display {
    return _userDisplay;
  }
}
