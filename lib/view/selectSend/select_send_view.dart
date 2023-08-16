// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/general/general_view.dart';

void main() {
  runApp(SendView());
}

class SendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SendApp(),
    );
  }
}

class SendApp extends StatefulWidget {
  @override
  State<SendApp> createState() => _SendAppState();
}

class _SendAppState extends State<SendApp> {
  final TextEditingController Sender = TextEditingController();
  String SavedSender = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => RouteHelper.push(context, SmsReadView())),
        centerTitle: true,
        title:
            Text("Mesaj Alınacak Kişi", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 150,
          ),
          TextField(
            controller: Sender,
            decoration: InputDecoration(
              hintText: AppConstant.SEND_SMS_HINT_TEXT,
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  Sender.clear();
                },
                icon: Icon(Icons.clear),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              SavedSender = Sender.text;
              RouteHelper.push(context, SmsReadView());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 120),
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green[700],
              ),
              child: Text(
                "Kaydet",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
