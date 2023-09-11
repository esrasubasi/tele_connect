import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/error_text_helper.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:tele_connect/view/update_person/update_person_view.dart';

class UpdatePersonViewModel extends ChangeNotifier {
  final TextEditingController textNameU = TextEditingController();
  final TextEditingController textPhoneU = TextEditingController();
  final TextEditingController textEmailU = TextEditingController();
  void callP(int test) {
    if (test == 1) {
      textEmailU.text = oldP.personEmail;
      textNameU.text = oldP.personName;
      textPhoneU.text = oldP.personNumber.replaceAll(oldP.personCountryCode, "");
    }
  }

  bool numtrueUP = false;
  String addnumUP = "";
  bool isLoadingAdd = false;
  String addNumber = "";
  void updateP(BuildContext con) async {
    if (numtrueUP == false) {
      ErrorText.errorMessage(con, AppConstant.invalidNumberError);
    } else {
      String oldPName = oldP.personName;
      String coucode = oldP.personCountryCode;
      addNumber = oldP.personNumber;
      if (addnumUP.length > 5) {
        coucode = addnumUP.replaceAll(textPhoneU.text, "");
      }

      int mailvalidcounter = 0;
      if (textNameU.text == "" || textEmailU.text == "" && textPhoneU.text == "") {
        ErrorText.errorMessage(con, AppConstant.errorCantEmptyAdd);
      } else {
        String addName = textNameU.text;

        if (textPhoneU.text.isNotEmpty && addnumUP.isNotEmpty) {
          addNumber = addnumUP;
        }
        String addEmail = textEmailU.text;
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
            await deletePerson(oldPName).timeout(const Duration(seconds: 10));
            await addPerson(addName, addNumber, addEmail, coucode).timeout(const Duration(seconds: 10));

            isLoadingAdd = false;
            notifyListeners();
            RouteHelper.pop(con, const Home());
          } catch (e) {
            isLoadingAdd = false;
            notifyListeners();
            ErrorText.errorMessage(con, AppConstant.userChangeError);
            deletePerson(addName);
          }
        } else {
          ErrorText.errorMessage(con, AppConstant.errorMail);
        }
      }
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deletePerson(String personName) async {
    await FirebaseFirestore.instance.collection("Person").doc(personName).delete();
  }

  Future<void> addPerson(String name, String number, String email, String coucod) async {
    await _firestore.collection("Person").doc(name).set({
      "PersonName": name,
      "PersonNumber": number,
      "PersonEmail": email,
      "PersonCountryCode": coucod,
    });
  }
}
