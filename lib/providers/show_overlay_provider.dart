import 'package:flutter/material.dart';

class ShowOverlayProvider extends ChangeNotifier {
  bool isShowOverlay = true;

  void toggleisShowOverlay() {
    isShowOverlay = !isShowOverlay;
    notifyListeners();
  }
}
