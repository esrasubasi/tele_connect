// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/components/custom_textfield.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/general/general_view.dart';
import '../../core/helper/dynamic_helper.dart';
import 'package:tele_connect/view/update_person/update_person_view_model.dart';
import 'package:tele_connect/core/model/person_model.dart';

Person oldP = Person(personName: "personName", personNumber: "personNumber", personEmail: "personEmail", personCountryCode: "personCountryCode");

class PersonUpdateApp extends StatefulWidget {
  @override
  State<PersonUpdateApp> createState() => _PersonUpdateAppState();
}

class _PersonUpdateAppState extends BaseState<PersonUpdateApp> {
  FocusNode focusNode = FocusNode();
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    final updateProvider = Provider.of<UpdatePersonViewModel>(context);
    updateProvider.callP(counter);
    counter = 2;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: mainWhite),
            onPressed: () {
              updateProvider.callP(1);
              RouteHelper.push(context, Home());
            }),
        centerTitle: true,
        title: Text("Mesaj Gönderilecek Kişi Güncelleme", style: TextStyle(color: mainWhite)),
        backgroundColor: mainColorGreen700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: dynamicHeight(0.14)),
              IntlPhoneField(
                  initialValue: oldP.personCountryCode,
                  invalidNumberMessage: AppConstant.sendSmsSelectInvalid,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: AppConstant.sendSmsHintText,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "tr",
                  onChanged: (phone) {
                    updateProvider.addnum = phone.completeNumber;
                  },
                  onCountryChanged: (country) {},
                  controller: updateProvider.textPhoneU),
              SizedBox(
                height: dynamicHeight(0.04),
              ),
              CustomTextField(controller: updateProvider.textNameU, keyboardType: TextInputType.name, hintText: AppConstant.hintTextName, maxLenght: 50),
              SizedBox(height: dynamicHeight(0.04)),
              CustomTextField(controller: updateProvider.textEmailU, keyboardType: TextInputType.emailAddress, hintText: AppConstant.hintTextEmail, maxLenght: 350),
              SizedBox(height: dynamicHeight(0.04)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: dynamicWidth(0.27)),
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: mainColorGreen700,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: mainColorGreen700),
                    onPressed: () {
                      updateProvider.updateP(context);
                      updateProvider.callP(1);
                    },
                    child: updateProvider.isLoadingAdd
                        ? CircularProgressIndicator(
                            color: mainWhite,
                            backgroundColor: mainColorGreen700,
                          )
                        : Text(
                            AppConstant.saveText,
                            style: TextStyle(
                              fontSize: 25,
                              color: mainWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
