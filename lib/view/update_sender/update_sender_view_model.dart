import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import 'package:tele_connect/view/update_sender/update_sender_view.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//çift notify düzeltebiliyorsan düzelt

class UpdateSenderViewModel extends ChangeNotifier {
  String withoutcountry = "";
  final TextEditingController SenderName = TextEditingController(text: oldS.SenderName);

  final TextEditingController SenderPhone = TextEditingController(text: oldS.SenderNumber);
  String oldnam = oldS.SenderName;
  bool isLoading = false;
  String addnum = "";
  void updatesender(BuildContext con) async {
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
        await updateSender(addSenderName, addSenderNumber, oldnam).timeout(Duration(seconds: 10));
        isLoading = false;
        notifyListeners();
        RouteHelper.push(con, SmsReadView());
      } catch (e) {
        isLoading = false;
        notifyListeners();
        errorMessage(con, "Kişi Değiştirlirken Bir Hata Oluştu!");
        deleteSender(addSenderName);
      }

      RouteHelper.push(con, SmsReadView());
    }
  }

  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  Future<void> updateSender(String name, String number, String oldnam) async {
    await _firestor.collection("Numbers").doc(oldnam).update({
      "SenderName": name,
      "SenderNumber": number,
    });
  }

  Future<void> deleteSender(String SenderName) async {
    await FirebaseFirestore.instance.collection("Numbers").doc(SenderName).delete();
  }
}
