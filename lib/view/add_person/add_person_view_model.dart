// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:tele_connect/core/model/person_model.dart';

class AddPersonViewModel extends ChangeNotifier {
  String addnum = "";
  bool isLoadingAdd = false;
  String withoutC = "";
  String countrycode = "";
  void addnew(BuildContext con) async {
    withoutC = textPhone.text;
    countrycode = addnum.replaceAll(withoutC, "");

    int mailvalidcounter = 0;
    if (textName.text == "" || textEmail.text == "" && textPhone.text == "") {
      errorMessage(con, AppConstant.ERROR_CANT_EMPTY_ADD);
    } else {
      String addName = textName.text;
      String addNumber = "-";
      if (textPhone.text.isNotEmpty) {
        addNumber = addnum;
      }
      String addEmail = textEmail.text;
      if (addEmail == "") {
        addEmail = "-";
      } else {
        for (int i = 0; i < addEmail.length; i++) {
          if (addEmail[i] == "@") {
            mailvalidcounter++;
          }
        }
      }
      if (addNumber == "") {
        addNumber = "-";
      }
      if (mailvalidcounter == 1 || addEmail == "-") {
        isLoadingAdd = true;
        notifyListeners();

        try {
          await addPerson(addName, addNumber, addEmail, countrycode).timeout(Duration(seconds: 10));
          isLoadingAdd = false;
          notifyListeners();
          RouteHelper.push(con, SmsReadView());
        } catch (e) {
          isLoadingAdd = false;
          notifyListeners();
          errorMessage(con, "Kişi Eklenirken Bir Hata Oluştu!");
          deletePerson(addName);
        }
      } else {
        errorMessage(con, AppConstant.ERROR_MAIL);
      }
    }
  }

  final TextEditingController textName = TextEditingController();
  final TextEditingController textPhone = TextEditingController();
  final TextEditingController textEmail = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPerson(String name, String number, String email, String coucod) async {
    await _firestore.collection("Person").doc(name).set({
      "PersonName": name,
      "PersonNumber": number,
      "PersonEmail": email,
      "PersonCountryCode": coucod,
    });
  }

  Future<void> deletePerson(String personName) async {
    await FirebaseFirestore.instance.collection("Person").doc(personName).delete();
  }
}
