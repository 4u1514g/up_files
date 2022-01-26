import 'package:flutter/cupertino.dart';

class SettingProvider with ChangeNotifier {
  bool show = true;
  void change(bool a){
    show=a;
    notifyListeners();
  }
}