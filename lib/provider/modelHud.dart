import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
class ModelHud extends ChangeNotifier{
  bool isloading=false;

  changeisLoading(bool value){
    isloading=value;
    notifyListeners();

  }
}