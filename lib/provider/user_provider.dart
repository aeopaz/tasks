import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _userInfo = {};

  Map<String, dynamic> get userInfo {
    return _userInfo;
  }

  void setUserInfo(info) {
    _userInfo = info;
    notifyListeners();
  }
}
