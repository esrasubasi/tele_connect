// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../core/helper/route_helper.dart';
import '../general/general_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSenderViewModel {
  final TextEditingController SenderName = TextEditingController();

  final TextEditingController SenderPhone = TextEditingController();

  void addnew(BuildContext con) async {
    String addSenderName = SenderName.text;
    String addSenderNumber = SenderPhone.text;

    await addSender(addSenderName, addSenderNumber);

    RouteHelper.push(con, SmsReadView());
  }

  final FirebaseFirestore _firestor = FirebaseFirestore.instance;

  Future<void> addSender(String name, String number) async {
    await _firestor.collection("Numbers").doc(name).set({
      "SenderName": name,
      "SenderNumber": number,
    });
  }
}
