import 'package:flutter/material.dart';

class ListAppProvider with ChangeNotifier {
  Map<String, dynamic> _listApp = {};

  Map<String, dynamic> get listApp {
    return _listApp;
  }

  void setListApp(list) {
    _listApp = list;
    notifyListeners();
  }
}
