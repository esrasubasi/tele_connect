import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddPersonViewModel{
  final TextEditingController textName = TextEditingController();
  final TextEditingController textPhone = TextEditingController();
  final TextEditingController textEmail = TextEditingController();

}

class PersonAddViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPerson(String name, String number, String email) async {
    await _firestore.collection("Person").doc(name).set({
      "PersonName": name,
      "PersonNumber": number,
      "PersonEmail": email,
    });
  }
}