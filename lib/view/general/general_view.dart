// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/core/model/sender_model.dart';
import 'package:tele_connect/core/provider/switch_provider.dart';
import 'package:tele_connect/main.dart';
import 'package:tele_connect/view/add_person/add_person_view.dart';
import 'package:tele_connect/view/general/general_view_model.dart';
import 'package:tele_connect/core/model/person_model.dart';
import 'package:tele_connect/view/selectSend/select_send_view.dart';
import 'package:tele_connect/core/components/screen_field.dart';
import '../../core/api/api.dart';
import '../../core/model/dto_mail_request.dart';
import '../selectSend/select_send_view_model.dart';

class SmsReadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SwitchProvider(),
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends BaseState<Home> {
  final GeneralViewModel viewModel = GeneralViewModel();
  final SMSReadViewModel readModel = SMSReadViewModel();

  void initState() {
    super.initState();
    readModel.getPermission().then((value) {
      if (value) {
        readModel.plugin.read();

        readModel.plugin.smsStream.listen((event) {
          setState(() {
            readModel.sms = event.body;
            readModel.sender = event.sender;
            readModel.time = event.timeReceived.toString();
            readModel.onSmsReceived(readModel.sms);
            readModel.sendSMSMethod();
            readModel.mailSender();
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final swiprovider = Provider.of<SwitchProvider>(context);
    bool isOn = swiprovider.isOn;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppConstant.GENERAL_TITLE_TEXT,
          style: TextStyle(color: ColorConstant.MAIN_COLOR),
        ),
        backgroundColor: ColorConstant.MAIN_COLOR_GREEN700,
      ),
      backgroundColor: ColorConstant.MAIN_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: dynamicHeight(0.01),
              ),
              Switch(
                value: isOn,
                onChanged: (value) {
                  swiprovider.toggleIsOn(value);
                },
                activeColor: ColorConstant.MAIN_COLOR_GREEN700,
              ),
              Text(
                "Mesaj ve Mail Atılacak Kişiler",
                style: TextStyle(color: ColorConstant.MAIN_BLACK54, fontWeight: FontWeight.bold, fontSize: 18),
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
                    height: dynamicHeight(0.3),
                    width: dynamicWidth(0.95),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: ColorConstant.MAIN_BLACK54, width: 3),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [for (final person in persons) PadCheckBP(person), Text(recipients.toString())],
                      ),
                    ),
                  );
                },
              ),
              Text(
                "Mesaj Alınacak Kişiler",
                style: TextStyle(color: ColorConstant.MAIN_BLACK54, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: viewModel.sendersStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final senders = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Senders(
                        SenderName: data['SenderName'],
                        SenderNumber: data['SenderNumber'],
                        SenderSelect: data['SenderSelect'] ?? false,
                      );
                    }).toList();
                    return Container(
                      height: dynamicHeight(0.3),
                      width: dynamicWidth(0.95),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: ColorConstant.MAIN_BLACK54, width: 3),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [for (final sender in senders) PadCheckBS(sender), Text(sendernumbers.toString())],
                        ),
                      ),
                    );
                  }),
              SafeArea(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          RouteHelper.push(context, SendView());
                        },
                        icon: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(Icons.message),
                        ),
                        iconSize: 100,
                        color: ColorConstant.MAIN_COLOR_GREEN700),
                    Expanded(
                      child: SizedBox(),
                    ),
                    IconButton(
                        onPressed: () {
                          RouteHelper.push(context, PersonView());
                        },
                        icon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(Icons.add_circle),
                        ),
                        iconSize: 100,
                        color: ColorConstant.MAIN_COLOR_GREEN700),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding PadCheckBP(Person person) {
    ifmethod(person);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [SlidableAction(backgroundColor: ColorConstant.MAIN_COLOR_RED, icon: Icons.delete, label: "Delete", onPressed: (context) => viewModel.deletePerson(person.personName))],
        ),
        child: CheckboxListTile(
          title: Text(person.personName),
          subtitle: Text(person.personNumber),
          value: person.personSelect,
          onChanged: (bool? newValue) {
            viewModel.updatePersonSelect(person.personName, newValue);
          },
          activeColor: ColorConstant.MAIN_COLOR_GREEN700,
          checkColor: ColorConstant.MAIN_COLOR,
          tileColor: ColorConstant.MAIN_COLOR,
        ),
      ),
    );
  }

  Padding PadCheckBS(Senders sender) {
    ifmethodS(sender);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [SlidableAction(backgroundColor: ColorConstant.MAIN_COLOR_RED, icon: Icons.delete, label: "Delete", onPressed: (context) => viewModel.deleteSender(sender.SenderName))],
        ),
        child: CheckboxListTile(
          title: Text(sender.SenderName),
          subtitle: Text(sender.SenderNumber),
          value: sender.SenderSelect,
          onChanged: (bool? newValue) {
            viewModel.updateSenderSelect(sender.SenderName, newValue);
          },
          activeColor: ColorConstant.MAIN_COLOR_GREEN700,
          checkColor: ColorConstant.MAIN_COLOR,
          tileColor: ColorConstant.MAIN_COLOR,
        ),
      ),
    );
  }
}
