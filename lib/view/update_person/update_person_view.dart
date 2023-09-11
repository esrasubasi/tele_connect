import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
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
  const PersonUpdateApp({super.key});

  @override
  State<PersonUpdateApp> createState() => _PersonUpdateAppState();
}

class _PersonUpdateAppState extends BaseState<PersonUpdateApp> {
  FocusNode focusNode = FocusNode();
  int counter = 1;
  bool numcheckUP = false;
  var countryUP = countries.firstWhere((element) => element.dialCode == oldP.personCountryCode.replaceAll("+", ""));
  @override
  Widget build(BuildContext context) {
    final updateProvider = Provider.of<UpdatePersonViewModel>(context);
    updateProvider.callP(counter);
    counter = 2;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: mainWhite),
            onPressed: () {
              updateProvider.callP(1);
              RouteHelper.pop(context, const Home());
            }),
        centerTitle: true,
        title: const Text(AppConstant.personUpdate, style: TextStyle(color: mainWhite)),
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
                  decoration: const InputDecoration(
                    labelText: AppConstant.sendSmsHintText,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "tr",
                  onChanged: (phone) {
                    if (phone.number.length >= countryUP.minLength && phone.number.length <= countryUP.maxLength) {
                      numcheckUP = true;
                      updateProvider.numtrueUP = numcheckUP;
                    } else {
                      numcheckUP = false;
                      updateProvider.numtrueUP = numcheckUP;
                    }
                    updateProvider.addnumUP = phone.completeNumber;
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
                  padding: const EdgeInsets.all(18.0),
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
                        ? const CircularProgressIndicator(
                            color: mainWhite,
                            backgroundColor: mainColorGreen700,
                          )
                        : const Text(
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
