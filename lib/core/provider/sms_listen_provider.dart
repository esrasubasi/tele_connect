import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readsms/readsms.dart';
import 'package:sms_receiver/sms_receiver.dart';

import '../api/api.dart';
import '../model/dto_mail_request.dart';

List<String> recipients = [];
List<String> mails = [];
List<String> sendernumbers = [];

class SMSReadViewModel extends ChangeNotifier {
  final plugin = Readsms();
  String sms = '';
  String sender = '';
  SmsReceiver? smsReceiver;

  Future<void> startListening() async {
    bool hasPermission = await getPermission();
    if (hasPermission) {
      plugin.read();

      plugin.smsStream.listen((event) {
        sms = event.body;
        sender = event.sender;
        sendSMSMethod();
        mailSender();
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    plugin.dispose();
  }

  void mailSender() {
    bool check = false;
    for (int i = 0; i < sendernumbers.length; i++) {
      if (sendernumbers[i] == sender) {
        check = true;
      }
    }
    if (check == true) {
      Api().sendEmail(DTOMailRequest(to: mails, cc: mails, bcc: [], body: "<html><body><h1>$sms</h1></body></html>", subject: "VPN CODE", contentType: "text/html"));
    }
  }

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
  // void startListeningMethod() async {
  //   if (smsReceiver == null) return;
  //   await smsReceiver?.startListening();

  // }

  // void stopListeningMethod() async {
  //   if (smsReceiver == null) return;
  //   await smsReceiver?.stopListening();

  // }

  void sendSMSMethod() async {
    bool check = false;
    for (int i = 0; i < sendernumbers.length; i++) {
      if (sendernumbers[i] == sender) {
        check = true;
      }
    }
    if (check == true) {
      await sendSMS(message: sms, recipients: recipients, sendDirect: true);
    }
  }
}
