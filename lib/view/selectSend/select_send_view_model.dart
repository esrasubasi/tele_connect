// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/feedback_helper.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//isLoading çift notifylistener kullanmadan olmuyo

//isloading kısmında patlıyo orayı düzelt

//+90 kısmına ülke seçtir
class AddSenderViewModel extends ChangeNotifier {
  final TextEditingController SenderName = TextEditingController();

  final TextEditingController SenderPhone = TextEditingController();

  bool isLoading = false;

  void addnew(BuildContext con) async {
    if (SenderName.text == "" || SenderPhone.text == "") {
      errorMessage(con, AppConstant.ERROR_CANT_EMPTY_SENDER);
    } else {
      String addSenderName = SenderName.text;
      String addSenderNumber = SenderPhone.text;

      isLoading = true;
      notifyListeners();
      await addSender(addSenderName, addSenderNumber);

      isLoading = false;
      notifyListeners();

      RouteHelper.push(con, SmsReadView());
    }
  }

  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  Future<void> addSender(String name, String number) async {
    await _firestor.collection("Numbers").doc(name).set({
      "SenderName": name,
      "SenderNumber": number,
    });
  }
}
