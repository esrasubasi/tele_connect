// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/components/custom_textfield.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/add_person/add_person_view_model.dart';
import 'package:tele_connect/view/general/general_view.dart';
import '../../core/helper/dynamic_helper.dart';

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
        leading: IconButton(icon: Icon(Icons.arrow_back, color: mainWhite), onPressed: () => RouteHelper.push(context, Home())),
        centerTitle: true,
        title: Text(AppConstant.personText, style: TextStyle(color: mainWhite)),
        backgroundColor: mainColorGreen700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: Consumer<AddPersonViewModel>(builder: (context, personViewModel, _) {
          return Column(
            children: [
              SizedBox(height: dynamicHeight(0.14)),
              IntlPhoneField(
                  initialCountryCode: "TR",
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
                    personViewModel.addnum = phone.completeNumber;
                  },
                  onCountryChanged: (country) {},
                  controller: personViewModel.textPhone),
              SizedBox(
                height: dynamicHeight(0.04),
              ),
              CustomTextField(controller: personViewModel.textName, keyboardType: TextInputType.name, hintText: AppConstant.hintTextName, maxLenght: 50),
              SizedBox(height: dynamicHeight(0.04)),
              CustomTextField(controller: personViewModel.textEmail, keyboardType: TextInputType.emailAddress, hintText: AppConstant.hintTextEmail, maxLenght: 350),
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
                      personViewModel.addnew(context);
                    },
                    child: personViewModel.isLoadingAdd
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
          );
        })),
      ),
    );
  }
}
