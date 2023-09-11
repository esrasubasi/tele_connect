import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/core/model/sender_model.dart';
import 'package:tele_connect/core/provider/switch_provider.dart';
import 'package:tele_connect/core/components/double_check_box.dart';
import 'package:tele_connect/view/add_person/add_person_view.dart';
import 'package:tele_connect/view/general/general_view_model.dart';
import 'package:tele_connect/core/model/person_model.dart';
import 'package:tele_connect/view/select_send/select_send_view.dart';
import 'package:tele_connect/core/helper/dynamic_helper.dart';
import 'package:tele_connect/view/update_person/update_person_view.dart';
import 'package:tele_connect/view/update_sender/update_sender_view.dart';

import '../../core/provider/sms_listen_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

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
        title: const Text(
          AppConstant.generalTitleText,
          style: TextStyle(color: mainWhite),
        ),
        backgroundColor: mainColorGreen700,
      ),
      backgroundColor: mainWhite,
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: mainColorGreen700,
        iconSize: 40,
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.send_rounded),
            icon: Icon(Icons.send),
            label: AppConstant.containerNameSend,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.message_rounded),
            icon: Icon(Icons.message),
            label: AppConstant.containerNameSender,
          ),
        ],
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: <Widget>[
        SingleChildScrollView(
          child: Column(
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
                activeColor: mainColorGreen700,
              ),
              SizedBox(
                height: dynamicHeight(0.01),
              ),
              Row(
                children: [
                  SizedBox(
                    width: dynamicWidth(0.06),
                  ),
                  const Text(
                    AppConstant.userInformation,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: mainB54),
                  ),
                  SizedBox(
                    width: dynamicWidth(0.41),
                  ),
                  const Icon(
                    Icons.send,
                    color: mainB54,
                  ),
                  SizedBox(width: dynamicWidth(0.057)),
                  const Icon(
                    Icons.mail,
                    color: mainB54,
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: viewModel.personsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final persons = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Person(
                      personName: data['PersonName'] ?? "",
                      personNumber: data['PersonNumber'] ?? "",
                      personEmail: data['PersonEmail'] ?? "",
                      personCountryCode: data['PersonCountryCode'] ?? "",
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
                      border: Border.all(color: mainB54, width: 3),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                for (final person in persons) padCheckBP(person),
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
                      RouteHelper.push(maincontext, const PersonApp());
                    },
                    icon: const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Icon(Icons.person_add),
                    ),
                    iconSize: 100,
                    color: mainColorGreen700),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
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
                activeColor: mainColorGreen700,
              ),
              SizedBox(
                height: dynamicHeight(0.01),
              ),
              Row(
                children: [
                  SizedBox(
                    width: dynamicWidth(0.07),
                  ),
                  const Text(
                    AppConstant.userInformation,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: mainB54),
                  ),
                  SizedBox(
                    width: dynamicWidth(0.53),
                  ),
                  const Icon(
                    Icons.send,
                    color: mainB54,
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: viewModel.sendersStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final senders = snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Senders(
                        SenderName: data['SenderName'] ?? "",
                        SenderNumber: data['SenderNumber'] ?? "",
                        SenderSelect: data['SenderSelect'] ?? false,
                        SenderCountryCode: data['SenderCountryCode'] ?? "",
                      );
                    }).toList();
                    return Container(
                      height: dynamicHeight(0.4),
                      width: dynamicWidth(0.95),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: mainB54, width: 3),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [for (final sender in senders) padCheckBS(sender), Text(sendernumbers.toString())],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: dynamicHeight(0.01),
              ),
              Center(
                child: IconButton(
                    onPressed: () {
                      RouteHelper.push(maincontext, const SendApp());
                    },
                    icon: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.add_comment),
                    ),
                    iconSize: 100,
                    color: mainColorGreen700),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }

  Padding padCheckBP(Person person) {
    checkIfinTel(person);
    checkIfinMail(person);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
              backgroundColor: mainBlue,
              icon: Icons.update,
              label: "Güncelle",
              onPressed: (context) {
                oldP = Person(personName: person.personName, personNumber: person.personNumber, personEmail: person.personEmail, personCountryCode: person.personCountryCode);
                RouteHelper.push(context, const PersonUpdateApp());
              })
        ]),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [SlidableAction(backgroundColor: mainRed, icon: Icons.delete, label: "Sil", onPressed: (context) => viewModel.deletePerson(person.personName))],
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

  Padding padCheckBS(Senders sender) {
    checkIfinSend(sender);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
              backgroundColor: mainBlue,
              icon: Icons.update,
              label: "Güncelle",
              onPressed: (context) {
                oldS = Senders(SenderName: sender.SenderName, SenderNumber: sender.SenderNumber, SenderCountryCode: sender.SenderCountryCode);
                RouteHelper.push(context, const SendUpdateApp());
              })
        ]),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [SlidableAction(backgroundColor: mainRed, icon: Icons.delete, label: "Sil", onPressed: (context) => viewModel.deleteSender(sender.SenderName))],
        ),
        child: CheckboxListTile(
          title: Text(sender.SenderName),
          subtitle: Text(sender.SenderNumber),
          value: sender.SenderSelect,
          onChanged: (bool? newValue) {
            viewModel.updateSenderSelect(sender.SenderName, newValue);
          },
          activeColor: mainColorGreen700,
          checkColor: mainWhite,
          tileColor: mainWhite,
        ),
      ),
    );
  }
}
