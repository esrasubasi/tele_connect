// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/view/add_person/add_person_view_model.dart';
import 'package:tele_connect/view/general/general_view.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/view/select_send/select_send_view_model.dart';
import 'package:tele_connect/view/update_person/update_person_view_model.dart';
import 'package:tele_connect/view/update_sender/update_sender_view_model.dart';
import 'core/provider/sms_listen_provider.dart';
import 'core/provider/switch_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SMSReadViewModel()),
          ChangeNotifierProvider(create: (context) => SwitchProvider()),
          ChangeNotifierProvider(create: (context) => UpdateSenderViewModel()),
          ChangeNotifierProvider(create: (context) => UpdatePersonViewModel()),
          ChangeNotifierProvider(create: (context) => AddSenderViewModel()),
          ChangeNotifierProvider(create: (context) => AddPersonViewModel()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
                future: _initialization,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(AppConstant.errorText));
                  } else if (snapshot.hasData) {
                    return Home();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
