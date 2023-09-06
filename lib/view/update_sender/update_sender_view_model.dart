// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import 'package:tele_connect/view/update_sender/update_sender_view.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateSenderViewModel extends ChangeNotifier {
  final TextEditingController SenderName = TextEditingController();

  final TextEditingController SenderPhone = TextEditingController();
  String country = "";
  void call() {
    SenderName.text = oldS.SenderName;

    SenderPhone.text = oldS.SenderNumber.replaceAll(oldS.SenderCountryCode, "");
  }

  String oldnam = oldS.SenderName;
  bool isLoading = false;
  String addnum = "";

  void updatesender(BuildContext con) async {
    country = addnum.replaceAll(SenderPhone.text, "");
    if (SenderName.text == "" || SenderPhone.text == "") {
      ErrorText.errorMessage(con, AppConstant.errorcantEmptySender);
    } else {
      String addSenderName = SenderName.text;
      String addSenderNumber = "-";
      if (SenderPhone.text.isNotEmpty) {
        addSenderNumber = addnum;
      }

      isLoading = true;
      notifyListeners();
      try {
        await deleteSender(oldnam).timeout(const Duration(seconds: 10));
        await addSender(addSenderName, addSenderNumber, country).timeout(const Duration(seconds: 10));
        isLoading = false;
        notifyListeners();
        RouteHelper.push(con, Home());
      } catch (e) {
        isLoading = false;
        notifyListeners();
        ErrorText.errorMessage(con, AppConstant.userChangeError);
        deleteSender(addSenderName);
      }

      RouteHelper.push(con, Home());
    }
  }

  @override
  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  Future<void> addSender(String name, String number, String countrycode) async {
    await _firestor.collection("Numbers").doc(name).set({
      "SenderName": name,
      "SenderNumber": number,
      "SenderCountryCode": countrycode,
    });
  }

  Future<void> deleteSender(String SenderName) async {
    await FirebaseFirestore.instance.collection("Numbers").doc(SenderName).delete();
  }
}
