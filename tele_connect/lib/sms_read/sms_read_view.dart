import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tele_connect/sms_read/sms_read_view_model.dart';

class SMSReadView extends StatefulWidget {
  const SMSReadView({super.key});

  @override
  State<SMSReadView> createState() => _SMSReadViewState();
}

class _SMSReadViewState extends State<SMSReadView> {
  @override
  Widget build(BuildContext context) {
    SMSReadViewModel _viewModel = SMSReadViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tele Connect'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: Text(_viewModel.textContent ?? 'boş'),
          ),
          ElevatedButton(
            onPressed: _viewModel.startListeningMethod,
            child: const Text('Tekrar Dinle'),
          ),
          ElevatedButton(
              child: const Text('Stop Listener'),
              onPressed: () {
                setState(() {
                  _viewModel.stopListeningMethod();
                });
              }),
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
