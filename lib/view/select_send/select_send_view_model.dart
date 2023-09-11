// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSenderViewModel extends ChangeNotifier {
  final TextEditingController SenderName = TextEditingController();

  final TextEditingController SenderPhone = TextEditingController();
  void resetsender(int one) {
    if (one == 1) {
      SenderName.text = "";
      SenderPhone.text = "";
    }
  }

  bool numtrueS = false;
  bool isLoading = false;
  String addnum = "";
  String withoutS = "";
  String countrycode = "";
  void addnew(BuildContext con) async {
    if (numtrueS == false) {
      ErrorText.errorMessage(con, AppConstant.invalidNumberError);
    } else {
      withoutS = SenderPhone.text;
      countrycode = addnum.replaceAll(withoutS, "");
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
          await addSender(addSenderName, addSenderNumber, countrycode).timeout(const Duration(seconds: 10));
          isLoading = false;
          notifyListeners();
          RouteHelper.pop(con, const Home());
        } catch (e) {
          isLoading = false;
          notifyListeners();
          ErrorText.errorMessage(con, AppConstant.userAddError);
          deleteSender(addSenderName);
        }
      }
    }
  }

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
