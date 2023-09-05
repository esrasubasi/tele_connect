// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/core/model/sender_model.dart';
import 'package:tele_connect/core/provider/switch_provider.dart';
import 'package:tele_connect/core/widget/double_check_box.dart';
import 'package:tele_connect/view/add_person/add_person_view.dart';
import 'package:tele_connect/view/add_person/add_person_view_model.dart';
import 'package:tele_connect/view/general/general_view_model.dart';
import 'package:tele_connect/core/model/person_model.dart';
import 'package:tele_connect/view/selectSend/select_send_view.dart';
import 'package:tele_connect/core/components/screen_field.dart';
import 'package:tele_connect/view/update_person/update_person_view.dart';
import 'package:tele_connect/view/update_sender/update_sender_view.dart';

import '../../core/provider/button_provider.dart';
import '../../core/provider/sms_listen_provider.dart';

class SmsReadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SMSReadViewModel()),
        ChangeNotifierProvider(create: (context) => SwitchProvider()),
        ChangeNotifierProvider(create: (context) => ButtonProvider()),
      ],
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
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext maincontext) {
    final swiprovider = Provider.of<SwitchProvider>(maincontext);
    final readModelProvider = Provider.of<SMSReadViewModel>(maincontext, listen: false);
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
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: ColorConstant.MAIN_COLOR_GREEN700,
        iconSize: 40,
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person_add_rounded),
            icon: Icon(Icons.person_add),
            label: 'Mesaj Alınacaklar',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add_comment_rounded),
            icon: Icon(Icons.add_comment),
            label: 'Mesaj Atılacaklar',
          ),
        ],
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: <Widget>[
        Column(
          children: [
            Switch(
              value: isOn,
              onChanged: (value) {
                swiprovider.toggleIsOn(value);
                if (value) {
                  readModelProvider.startListening();
                } else {
                  readModelProvider.dispose();
                }
              },
              activeColor: ColorConstant.MAIN_COLOR_GREEN700,
            ),
            Text(
              AppConstant.CONTAINER_NAME_SEND,
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
                    personName: data['PersonName'] ?? "",
                    personNumber: data['PersonNumber'] ?? "",
                    personEmail: data['PersonEmail'] ?? "",
                    personSelectTel: data['PersonSelectTel'] ?? false,
                    personSelectMail: data['PersonSelectMail'] ?? false,
                  );
                }).toList();

                return Container(
                  height: dynamicHeight(0.45),
                  width: dynamicWidth(0.95),
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: ColorConstant.MAIN_BLACK54, width: 3),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: dynamicHeight(0.01),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: dynamicWidth(0.04),
                            ),
                            Text(
                              AppConstant.USER_INFORMATIONS,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstant.MAIN_BLACK54),
                            ),
                            SizedBox(
                              width: dynamicWidth(0.4),
                            ),
                            Icon(
                              Icons.send,
                              color: ColorConstant.MAIN_BLACK54,
                            ),
                            SizedBox(width: dynamicHeight(0.03)),
                            Icon(
                              Icons.mail,
                              color: ColorConstant.MAIN_BLACK54,
                            ),
                          ],
                        ),
                        Divider(
                          height: 3,
                          color: ColorConstant.MAIN_BLACK54,
                          thickness: 3,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              for (final person in persons) PadCheckBP(person),
                              Text("Telnos:${recipients.toString()}/Mails:${mails.toString()}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Center(
              child: IconButton(
                  onPressed: () {
                    RouteHelper.push(maincontext, PersonView());
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Icon(Icons.person_add),
                  ),
                  iconSize: 100,
                  color: ColorConstant.MAIN_COLOR_GREEN700),
            ),
          ],
        ),
        Column(
          children: [
            Switch(
              value: isOn,
              onChanged: (value) {
                swiprovider.toggleIsOn(value);
                if (value) {
                  readModelProvider.startListening();
                } else {
                  readModelProvider.dispose();
                }
              },
              activeColor: ColorConstant.MAIN_COLOR_GREEN700,
            ),
            Text(
              AppConstant.CONTAINER_NAME_SENDER,
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
                      SenderName: data['SenderName'] ?? "",
                      SenderNumber: data['SenderNumber'] ?? "",
                      SenderSelect: data['SenderSelect'] ?? false,
                    );
                  }).toList();
                  return Container(
                    height: dynamicHeight(0.45),
                    width: dynamicWidth(0.95),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: ColorConstant.MAIN_BLACK54, width: 3),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: dynamicHeight(0.01),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: dynamicWidth(0.04),
                              ),
                              Text(
                                AppConstant.USER_INFORMATIONS,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConstant.MAIN_BLACK54),
                              ),
                              SizedBox(
                                width: dynamicWidth(0.53),
                              ),
                              Icon(
                                Icons.send,
                                color: ColorConstant.MAIN_BLACK54,
                              ),
                            ],
                          ),
                          Divider(
                            color: ColorConstant.MAIN_BLACK54,
                            height: 3,
                            thickness: 3,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [for (final sender in senders) PadCheckBS(sender), Text(sendernumbers.toString())],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: dynamicHeight(0.06),
            ),
            Center(
              child: IconButton(
                  onPressed: () {
                    RouteHelper.push(maincontext, SendView());
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.add_comment),
                  ),
                  iconSize: 100,
                  color: ColorConstant.MAIN_COLOR_GREEN700),
            ),
          ],
        ),
      ][currentPageIndex],
    );
  }

  Padding PadCheckBP(Person person) {
    checkIfinTel(person);
    checkIfinMail(person);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
              backgroundColor: ColorConstant.MAIN_BLUE,
              icon: Icons.update,
              label: "Güncelle",
              onPressed: (context) {
                RouteHelper.push(context, PersonUpdateView());
                oldP = Person(personName: person.personName, personNumber: person.personNumber, personEmail: person.personEmail);
              })
        ]),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [SlidableAction(backgroundColor: ColorConstant.MAIN_COLOR_RED, icon: Icons.delete, label: "Sil", onPressed: (context) => viewModel.deletePerson(person.personName))],
        ),
        child: DoubleCheckboxListTile(
          isErrM: checkGiveError(person.personEmail),
          isErrNum: checkGiveError(person.personNumber),
          title: person.personName,
          subtitle: "${person.personNumber}\n${person.personEmail}",
          value1: person.personSelectTel,
          onChanged1: (bool? newValue1) {
            if (checkGiveError(person.personNumber) == false) {
              viewModel.updatePersonSelectTel(person.personName, newValue1);
            }
          },
          value2: person.personSelectMail,
          onChanged2: (bool? newValue2) {
            if (checkGiveError(person.personEmail) == false) {
              viewModel.updatePersonSelectMail(person.personName, newValue2);
            }
          },
        ),
      ),
    );
  }

  Padding PadCheckBS(Senders sender) {
    checkIfinSend(sender);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
              backgroundColor: ColorConstant.MAIN_BLUE,
              icon: Icons.update,
              label: "Güncelle",
              onPressed: (context) {
                RouteHelper.push(context, SendUpdateView());
                oldS = Senders(SenderName: sender.SenderName, SenderNumber: sender.SenderNumber);
              })
        ]),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [SlidableAction(backgroundColor: ColorConstant.MAIN_COLOR_RED, icon: Icons.delete, label: "Sil", onPressed: (context) => viewModel.deleteSender(sender.SenderName))],
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
