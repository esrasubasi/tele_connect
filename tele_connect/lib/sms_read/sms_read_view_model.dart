import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readsms/readsms.dart';
import 'package:sms_receiver/sms_receiver.dart';
import 'package:workmanager/workmanager.dart';

class SMSReadViewModel {
  final plugin = Readsms();
  String sms = '';
  String sender = '';
  String time = '';
  String? textContent = 'Mesajlar bekleniyor...';
  SmsReceiver? smsReceiver;

  List<String> recipients = ["+905536852708"];

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
    if (sender == "+905536852708") {
      await sendSMS(message: sms, recipients: recipients, sendDirect: true);
    }
  }

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      onSmsReceived(sms);
      sendSMS(message: sms, recipients: recipients);
      Workmanager().registerPeriodicTask(
        "periodic-task-identifier",
        "simplePeriodicTask",
        frequency: const Duration(minutes: 30),
      );
      return Future.value(true);
    });
  }
}
