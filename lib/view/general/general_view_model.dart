// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/core/model/person_model.dart';
import 'package:tele_connect/core/model/sender_model.dart';
import 'package:tele_connect/core/provider/sms_listen_provider.dart';

class GeneralViewModel {
  Stream<QuerySnapshot> get personsStream => FirebaseFirestore.instance.collection('Person').snapshots();
  Stream<QuerySnapshot> get sendersStream => FirebaseFirestore.instance.collection('Numbers').snapshots();

  Future<void> updatePersonSelectTel(String personName, bool? newValue) async {
    await FirebaseFirestore.instance.collection('Person').doc(personName).update({'PersonSelectTel': newValue});
  }

  Future<void> updatePersonSelectMail(String personName, bool? newValue) async {
    await FirebaseFirestore.instance.collection('Person').doc(personName).update({'PersonSelectMail': newValue});
  }

  Future<void> deletePerson(String personName) async {
    await FirebaseFirestore.instance.collection("Person").doc(personName).delete();
  }

  Future<void> updateSenderSelect(String SenderName, bool? newValue) async {
    await FirebaseFirestore.instance.collection('Numbers').doc(SenderName).update({'SenderSelect': newValue});
  }

  Future<void> deleteSender(String SenderName) async {
    await FirebaseFirestore.instance.collection("Numbers").doc(SenderName).delete();
  }
}

void checkIfinTel(Person person) {
  int counter = 0;
  if (person.personSelectTel == true) {
    for (int i = 0; i < recipients.length; i++) {
      if (recipients[i] == person.personNumber) {
        counter++;
      }
    }
    if (counter == 0) {
      recipients.add(person.personNumber);
    }
  } else {
    recipients.remove(person.personNumber);
  }
}

void checkIfinMail(Person person) {
  int counter = 0;
  if (person.personSelectMail == true) {
    for (int i = 0; i < mails.length; i++) {
      if (mails[i] == person.personEmail) {
        counter++;
      }
    }
    if (counter == 0) {
      mails.add(person.personEmail);
    }
  } else {
    mails.remove(person.personEmail);
  }
}

void checkIfinSend(Senders sender) {
  int counter = 0;
  if (sender.SenderSelect == true) {
    for (int i = 0; i < sendernumbers.length; i++) {
      if (sendernumbers[i] == sender.SenderNumber) {
        counter++;
      }
    }
    if (counter == 0) {
      sendernumbers.add(sender.SenderNumber);
    }
  } else {
    sendernumbers.remove(sender.SenderNumber);
  }
}

bool checkGiveError(String control) {
  if (control == "-") {
    return true;
  } else {
    return false;
  }
}
