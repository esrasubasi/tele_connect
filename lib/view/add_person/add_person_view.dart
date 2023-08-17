// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/add_person/add_person_view_model.dart';
import 'package:tele_connect/view/general/general_view.dart';

void main() {
  runApp(PersonView());
}

class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonApp(),
    );
  }
}

class PersonApp extends StatefulWidget {
  @override
  State<PersonApp> createState() => _PersonAppState();
}

class _PersonAppState extends State<PersonApp> {
  AddPersonViewModel personViewModel = AddPersonViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: ColorConstant.MAIN_COLORB), onPressed: () => RouteHelper.push(context, SmsReadView())),
        centerTitle: true,
        title: Text(AppConstant.PERSON_TEXT, style: TextStyle(color: ColorConstant.MAIN_COLOR)),
        backgroundColor: ColorConstant.MAIN_COLOR2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              TextField(
                controller: personViewModel.textName,
                decoration: InputDecoration(
                  hintText: AppConstant.HINT_TEXT_NAME,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      personViewModel.textName.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: personViewModel.textPhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: AppConstant.HINT_TEXT_NUMBER,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      personViewModel.textPhone.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: personViewModel.textEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: AppConstant.HINT_TEXT_EMAIL,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      personViewModel.textEmail.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () async {
                  String addName = personViewModel.textName.text;
                  String addNumber = personViewModel.textPhone.text;
                  String addEmail = personViewModel.textEmail.text;

                  await personViewModel.addPerson(addName, addNumber, addEmail);

                  RouteHelper.push(context, SmsReadView());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorConstant.MAIN_COLOR2,
                  ),
                  child: Text(
                    AppConstant.SAVE_TEXT,
                    style: TextStyle(
                      fontSize: 25,
                      color: ColorConstant.MAIN_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
