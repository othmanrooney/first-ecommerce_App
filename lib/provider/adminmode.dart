import 'package:flutter/cupertino.dart';
class Adminemode extends ChangeNotifier{
  bool isAdmin=false;
  changeIsAdmin(bool value){
    isAdmin=value;
    notifyListeners();
  }
}