import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
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
  const PersonApp({super.key});

  @override
  State<PersonApp> createState() => _PersonAppState();
}

class _PersonAppState extends BaseState<PersonApp> {
  FocusNode focusNode = FocusNode();
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final addpersonprovider = Provider.of<AddPersonViewModel>(context);
    addpersonprovider.resetP(counter);
    counter = 2;
    var country = countries.firstWhere((element) => element.code == "TR");
    bool numcheck = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: mainWhite), onPressed: () => RouteHelper.pop(context, const Home())),
        centerTitle: true,
        title: const Text(AppConstant.personText, style: TextStyle(color: mainWhite)),
        backgroundColor: mainColorGreen700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: dynamicHeight(0.14)),
              IntlPhoneField(
                  initialCountryCode: "TR",
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
                    if (phone.number.length >= country.minLength && phone.number.length <= country.maxLength) {
                      numcheck = true;
                      addpersonprovider.numtrue = numcheck;
                    } else {
                      numcheck = false;
                      addpersonprovider.numtrue = numcheck;
                    }
                    addpersonprovider.addnum = phone.completeNumber;
                  },
                  onCountryChanged: (country) {},
                  controller: addpersonprovider.textPhone),
              SizedBox(
                height: dynamicHeight(0.04),
              ),
              CustomTextField(controller: addpersonprovider.textName, keyboardType: TextInputType.name, hintText: AppConstant.hintTextName, maxLenght: 50),
              SizedBox(height: dynamicHeight(0.04)),
              CustomTextField(controller: addpersonprovider.textEmail, keyboardType: TextInputType.emailAddress, hintText: AppConstant.hintTextEmail, maxLenght: 350),
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
                      addpersonprovider.addnew(context);
                      addpersonprovider.resetP(1);
                    },
                    child: addpersonprovider.isLoadingAdd
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
