// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/components/custom_textfield.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/add_person/add_person_view_model.dart';
import 'package:tele_connect/view/general/general_view.dart';
import '../../core/components/screen_field.dart';

//+90 yazmasın
class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPersonViewModel(),
      child: MaterialApp(
        home: PersonApp(),
      ),
    );
  }
}

class PersonApp extends StatefulWidget {
  @override
  State<PersonApp> createState() => _PersonAppState();
}

class _PersonAppState extends BaseState<PersonApp> {
  FocusNode focusNode = FocusNode();
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
        child: SingleChildScrollView(child: Consumer<AddPersonViewModel>(builder: (context, personViewModel, _) {
          return Column(
            children: [
              SizedBox(height: dynamicHeight(0.14)),
              IntlPhoneField(
                  invalidNumberMessage: AppConstant.SEND_SMS_SELECT_INVALID,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: AppConstant.SEND_SMS_HINT_TEXT,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "tr",
                  onChanged: (phone) {
                    personViewModel.addnum = phone.completeNumber;
                  },
                  onCountryChanged: (country) {},
                  controller: personViewModel.textPhone),
              SizedBox(
                height: dynamicHeight(0.04),
              ),
              CustomTextField(controller: personViewModel.textName, keyboardType: TextInputType.name, hintText: AppConstant.HINT_TEXT_NAME, maxLenght: 50),
              SizedBox(height: dynamicHeight(0.04)),
              CustomTextField(controller: personViewModel.textEmail, keyboardType: TextInputType.emailAddress, hintText: AppConstant.HINT_TEXT_EMAIL, maxLenght: 350),
              SizedBox(height: dynamicHeight(0.04)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: dynamicWidth(0.27)),
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorConstant.MAIN_COLOR_GREEN700,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: ColorConstant.MAIN_COLOR_GREEN700),
                    onPressed: () {
                      personViewModel.addnew(context);
                    },
                    child: personViewModel.isLoadingAdd
                        ? CircularProgressIndicator(
                            color: ColorConstant.MAIN_COLOR,
                            backgroundColor: ColorConstant.MAIN_COLOR_GREEN700,
                          )
                        : Text(
                            AppConstant.SAVE_TEXT,
                            style: TextStyle(
                              fontSize: 25,
                              color: ColorConstant.MAIN_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )),
            ],
          );
        })),
      ),
    );
  }
}
