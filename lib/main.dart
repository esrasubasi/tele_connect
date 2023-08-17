// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/view/general/general_view.dart';

String SavedSender = "";
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
    return MaterialApp(
        home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(AppConstant.ERROR_TEXT));
              } else if (snapshot.hasData) {
                return SmsReadView();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
