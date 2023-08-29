import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/provider/sms_listen_provider.dart';

class ButtonProvider extends ChangeNotifier {
  int isOn = 0;
  bool isLoadingButton = false;
  bool isListeningTF = false;
  void IsOnListen(BuildContext con) async {
    isLoadingButton = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 400));
    isOn++;
    isLoadingButton = false;
    isListening(con);
    notifyListeners();
  }

  void isListening(BuildContext context) {
    final readModelPro = Provider.of<SMSReadViewModel>(context, listen: false);
    if (isOn % 2 == 1) {
      isListeningTF = true;
      readModelPro.startListening();
    } else {
      isListeningTF = false;
      readModelPro.dispose();
    }
    notifyListeners();
  }
}
