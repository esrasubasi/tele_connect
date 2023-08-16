// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/add_person/add_person_view.dart';
import 'package:tele_connect/view/general/general_view_model.dart';
import 'package:tele_connect/core/model/person_model.dart';
import 'package:tele_connect/view/selectSend/select_send_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SmsReadView());
}

class SmsReadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GeneralViewModel viewModel = GeneralViewModel();
  bool isOn = false;
  List<String> telnos = [];

  @override
  Widget build(BuildContext context) {
    telnos.clear;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Vpn Kodları",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Switch(
              value: isOn,
              onChanged: (value) {
                setState(
                  () {
                    isOn = value;
                    if (isOn == true) {
                    } else {}
                  },
                );
              },
              activeColor: Colors.green[700],
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: viewModel.personsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final persons = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return Person(
                    personName: data['PersonName'],
                    personNumber: data['PersonNumber'],
                    personEmail: data['PersonEmail'],
                    personSelect: data['PersonSelect'] ?? false,
                  );
                }).toList();

                return Container(
                  height: 300,
                  width: 500,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black54, width: 3),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (final person in persons) PadCheckB(person, telnos),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      RouteHelper.push(context, SendView());
                    },
                    icon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.message),
                    ),
                    iconSize: 100,
                    color: Colors.green[700]),
                SizedBox(
                  width: 135,
                ),
                IconButton(
                    onPressed: () {
                      RouteHelper.push(context, PersonView());
                    },
                    icon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.add_circle),
                    ),
                    iconSize: 100,
                    color: Colors.green[700]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding PadCheckB(Person person, List<String> telno) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: "Delete",
                onPressed: (context) =>
                    viewModel.deletePerson(person.personName))
          ],
        ),
        child: CheckboxListTile(
          title: Text(person.personName),
          subtitle: Text(person.personNumber),
          value: person.personSelect,
          onChanged: (bool? newValue) {
            viewModel.updatePersonSelect(person.personName, newValue);
            if (person.personSelect == false) {
              telno.add(person.personNumber);
            } else {
              telno.remove(person.personNumber);
            }
          },
          activeColor: Colors.green[700],
          checkColor: Colors.white,
          tileColor: Colors.white,
        ),
      ),
    );
  }
}
