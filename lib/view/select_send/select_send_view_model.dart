// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//çift notify düzeltebiliyorsan düzelt

class AddSenderViewModel extends ChangeNotifier {
  final TextEditingController SenderName = TextEditingController();

  final TextEditingController SenderPhone = TextEditingController();

  bool isLoading = false;
  String addnum = "";
  String withoutS = "";
  String countrycode = "";
  void addnew(BuildContext con) async {
    countrycode = addnum.replaceAll(withoutS, "");
    if (SenderName.text == "" || SenderPhone.text == "") {
      errorMessage(con, AppConstant.ERROR_CANT_EMPTY_SENDER);
    } else {
      String addSenderName = SenderName.text;
      String addSenderNumber = "-";
      if (SenderPhone.text.isNotEmpty) {
        addSenderNumber = addnum;
      }

      isLoading = true;
      notifyListeners();
      try {
        await addSender(addSenderName, addSenderNumber).timeout(Duration(seconds: 10));
        isLoading = false;
        notifyListeners();
        RouteHelper.push(con, SmsReadView());
      } catch (e) {
        isLoading = false;
        notifyListeners();
        errorMessage(con, "Kişi Eklenirken Bir Hata Oluştu!");
        deleteSender(addSenderName);
      }

      RouteHelper.push(con, SmsReadView());
    }
  }

  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  Future<void> addSender(String name, String number) async {
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
