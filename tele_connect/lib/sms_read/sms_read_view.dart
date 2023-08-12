import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tele_connect/sms_read/sms_read_view_model.dart';
import 'package:workmanager/workmanager.dart';

class SMSReadView extends StatefulWidget {
  const SMSReadView({super.key});

  @override
  State<SMSReadView> createState() => _SMSReadModelState();
}

class _SMSReadModelState extends State<SMSReadView> {
  SMSReadViewModel viewModel = SMSReadViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tele Connect'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: Text(viewModel.textContent ?? 'boş'),
          ),
          ElevatedButton(
            onPressed: viewModel.startListeningMethod,
            child: const Text('Tekrar Dinle'),
          ),
          ElevatedButton(
            onPressed: viewModel.stopListeningMethod,
            child: const Text('Dinleyiciyi Durdur'),
          ),
          const Divider(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
