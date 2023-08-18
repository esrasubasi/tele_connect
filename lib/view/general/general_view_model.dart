import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readsms/readsms.dart';
import 'package:sms_receiver/sms_receiver.dart';

final List<String> recipients = [];

class SMSReadViewModel {
  final plugin = Readsms();
  String sms = '';
  String sender = '';
  String time = '';
  String? textContent = 'Mesajlar bekleniyor...';
  SmsReceiver? smsReceiver;
  String SavedSend = "";

  Future<bool> getPermission() async {
    if (await Permission.sms.status == PermissionStatus.granted) {
      return true;
    } else {
      if (await Permission.sms.request() == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void onSmsReceived(String? message) {
    textContent = message;
  }

  void onTimeout() {
    textContent = 'Zaman doldu!!!';
  }

  void startListeningMethod() async {
    if (smsReceiver == null) return;
    await smsReceiver?.startListening();

    textContent = 'Mesajlar bekleniyor...';
  }

  void stopListeningMethod() async {
    if (smsReceiver == null) return;
    await smsReceiver?.stopListening();

    textContent = 'Dinleyici Durdu.';
  }

  void sendSMSMethod() async {
    if (sender == SavedSend) {
      await sendSMS(message: sms, recipients: recipients, sendDirect: true);
    }
  }
}

class GeneralViewModel {
  Stream<QuerySnapshot> get personsStream => FirebaseFirestore.instance.collection('Person').snapshots();

  Future<void> updatePersonSelect(String personName, bool? newValue) async {
    await FirebaseFirestore.instance.collection('Person').doc(personName).update({'PersonSelect': newValue});
  }

  Future<void> deletePerson(String personName) async {
    await FirebaseFirestore.instance.collection("Person").doc(personName).delete();
  }
}
