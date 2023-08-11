import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readsms/readsms.dart';
import 'package:sms_receiver/sms_receiver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _plugin = Readsms();
  String sms = '';
  String sender = '';
  String time = '';
  String? _textContent = 'Mesajlar bekleniyor...';
  SmsReceiver? _smsReceiver;

  @override
  void initState() {
    super.initState();
    _smsReceiver = SmsReceiver(onSmsReceived, onTimeout: onTimeout);
    _startListening();

    getPermission().then((value) {
      if (value == true) {
        _plugin.read();
        _plugin.smsStream.listen((event) {
          setState(() {
            sms = event.body;
            sender = event.sender;
            time = event.timeReceived.toString();
            _sendSMS();
          });
        });
      }
    });
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

  void onSmsReceived(String? message) {
    setState(() {
      _textContent = message;
    });
  }

  void onTimeout() {
    setState(() {
      _textContent = 'Zaman doldu!!!';
    });
  }

  void _startListening() async {
    if (_smsReceiver == null) return;
    await _smsReceiver?.startListening();
    setState(() {
      _textContent = 'Mesajlar bekleniyor...';
    });
  }

  void _stopListening() async {
    if (_smsReceiver == null) return;
    await _smsReceiver?.stopListening();
    setState(() {
      _textContent = 'Dinleyici Durdu.';
    });
  }

  List<String> recipients = ["+905313562627"];

  void _sendSMS() async {
    await sendSMS(message: sms, recipients: recipients, sendDirect: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tele Connect'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: Text(_textContent ?? 'boş'),
            ),
            ElevatedButton(
              onPressed: _startListening,
              child: const Text('Tekrar Dinle'),
            ),
            ElevatedButton(
              onPressed: _stopListening,
              child: const Text('Dinleyiciyi Durdur'),
            ),
            const Divider(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Yeni mesaj alındı: $sms'),
                  Text('Gönderen: $sender'),
                  Text('SMS Zamanı: $time'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
