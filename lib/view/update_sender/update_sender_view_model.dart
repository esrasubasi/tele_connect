// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import 'package:tele_connect/view/update_sender/update_sender_view.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateSenderViewModel extends ChangeNotifier {
  final TextEditingController SenderNameU = TextEditingController();

  final TextEditingController SenderPhoneU = TextEditingController();
  String country = "";
  void callS(int check) {
    if (check == 1) {
      SenderNameU.text = oldS.SenderName;

      SenderPhoneU.text = oldS.SenderNumber.replaceAll(oldS.SenderCountryCode, "");
    }
  }

  bool isLoading = false;
  String addnum = "";
  String addSenderNumber = oldS.SenderNumber;
  void updatesender(BuildContext con) async {
    String oldnam = oldS.SenderName;
    country = oldS.SenderCountryCode;
    if (addnum.length > 5) {
      country = addnum.replaceAll(SenderPhoneU.text, "");
    }

    if (SenderNameU.text == "" || SenderPhoneU.text == "") {
      ErrorText.errorMessage(con, AppConstant.errorcantEmptySender);
    } else {
      String addSenderName = SenderNameU.text;
      if (SenderPhoneU.text.isNotEmpty && addnum.isNotEmpty) {
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
