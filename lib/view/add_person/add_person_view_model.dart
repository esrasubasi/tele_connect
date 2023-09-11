import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';

class AddPersonViewModel extends ChangeNotifier {
  final TextEditingController textName = TextEditingController(text: "");
  final TextEditingController textPhone = TextEditingController(text: "");
  final TextEditingController textEmail = TextEditingController(text: "");

  void resetP(int counter) {
    if (counter == 1) {
      textEmail.text = "";
      textName.text = "";
      textPhone.text = "";
    }
  }

  bool numtrue = false;
  String addnum = "";
  bool isLoadingAdd = false;
  String withoutC = "";
  String countrycode = "";
  void addnew(BuildContext con) async {
    if (numtrue == false) {
      ErrorText.errorMessage(con, AppConstant.invalidNumberError);
    } else {
      withoutC = textPhone.text;
      countrycode = addnum.replaceAll(withoutC, "");

      int mailvalidcounter = 0;
      if (textName.text == "" || textEmail.text == "" && textPhone.text == "") {
        ErrorText.errorMessage(con, AppConstant.errorCantEmptyAdd);
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
            await addPerson(addName, addNumber, addEmail, countrycode).timeout(const Duration(seconds: 10));
            isLoadingAdd = false;
            notifyListeners();
            RouteHelper.pop(con, const Home());
          } catch (e) {
            isLoadingAdd = false;
            notifyListeners();
            ErrorText.errorMessage(con, AppConstant.userAddError);
            deletePerson(addName);
          }
        } else {
          ErrorText.errorMessage(con, AppConstant.errorMail);
        }
      }
    }
  }

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
