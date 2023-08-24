// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tele_connect/core/model/person_model.dart';
import 'package:tele_connect/core/model/sender_model.dart';
import 'package:tele_connect/core/provider/sms_listen_provider.dart';

class GeneralViewModel {
  Stream<QuerySnapshot> get personsStream => FirebaseFirestore.instance.collection('Person').snapshots();
  Stream<QuerySnapshot> get sendersStream => FirebaseFirestore.instance.collection('Numbers').snapshots();

  Future<void> updatePersonSelect(String personName, bool? newValue) async {
    await FirebaseFirestore.instance.collection('Person').doc(personName).update({'PersonSelect': newValue});
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

void checkIfin(Person person) {
  int counter = 0;
  if (person.personSelect == true) {
    for (int i = 0; i < recipients.length; i++) {
      if (recipients[i] == person.personNumber) {
        counter++;
      }
    }
    if (counter == 0) {
      recipients.add(person.personNumber);
      mails.add(person.personEmail);
    }
  } else {
    recipients.remove(person.personNumber);
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
