



import 'package:flutter/cupertino.dart';

class BottomNavigationProvider extends ChangeNotifier{
  int currentIndex=0;

  updateIndex(int value){
    currentIndex=value;
    notifyListeners();
  }

}