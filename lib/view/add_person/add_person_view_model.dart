// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';

bool isLoadingAdd = false;

//isLoading true flase 13,15
//+90 kısmına ülke seçtir
class AddPersonViewModel extends ChangeNotifier {
  void addnew(BuildContext con) async {
    String addName = textName.text;
    String addNumber = textPhone.text;
    String addEmail = textEmail.text;
    isLoadingAdd = true;

    notifyListeners();

    await addPerson(addName, addNumber, addEmail);

    isLoadingAdd = false;

    RouteHelper.push(con, SmsReadView());
  }

  final TextEditingController textName = TextEditingController();
  final TextEditingController textPhone = TextEditingController();
  final TextEditingController textEmail = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPerson(String name, String number, String email) async {
    await _firestore.collection("Person").doc(name).set({
      "PersonName": name,
      "PersonNumber": number,
      "PersonEmail": email,
    });
  }
}
