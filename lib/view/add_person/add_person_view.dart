// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tele_connect/core/components/custom_textfield.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/add_person/add_person_view_model.dart';
import 'package:tele_connect/view/general/general_view.dart';

import '../../core/components/screen_field.dart';

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

class _PersonAppState extends BaseState<PersonApp> {
  AddPersonViewModel personViewModel = AddPersonViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: ColorConstant.MAIN_BLACK), onPressed: () => RouteHelper.push(context, SmsReadView())),
        centerTitle: true,
        title: Text(AppConstant.PERSON_TEXT, style: TextStyle(color: ColorConstant.MAIN_COLOR)),
        backgroundColor: ColorConstant.MAIN_COLOR_GREEN700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: dynamicHeight(0.14)),
              CustomTextField(controller: personViewModel.textPhone, keyboardType: TextInputType.phone, hintText: AppConstant.HINT_TEXT_NUMBER),
              SizedBox(
                height: dynamicHeight(0.04),
              ),
              CustomTextField(controller: personViewModel.textName, keyboardType: TextInputType.name, hintText: AppConstant.HINT_TEXT_NAME),
              SizedBox(height: dynamicHeight(0.04)),
              CustomTextField(controller: personViewModel.textEmail, keyboardType: TextInputType.emailAddress, hintText: AppConstant.HINT_TEXT_EMAIL),
              SizedBox(height: dynamicHeight(0.04)),
              TextButton(
                onPressed: () {
                  personViewModel.addnew();
                  RouteHelper.push(context, SmsReadView());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.27),
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorConstant.MAIN_COLOR_GREEN700,
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
