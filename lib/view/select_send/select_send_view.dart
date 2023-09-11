import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/components/custom_textfield.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/general/general_view.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import '../../core/helper/dynamic_helper.dart';
import 'package:tele_connect/view/select_send/select_send_view_model.dart';

class SendApp extends StatefulWidget {
  const SendApp({super.key});

  @override
  State<SendApp> createState() => _SendAppState();
}

class _SendAppState extends BaseState<SendApp> {
  FocusNode focusNode = FocusNode();
  int count = 1;

  @override
  Widget build(BuildContext context) {
    final selectProvider = Provider.of<AddSenderViewModel>(context);
    selectProvider.resetsender(count);
    count = 2;
    var countryS = countries.firstWhere((element) => element.code == "TR");
    bool numcheckS = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: mainWhite), onPressed: () => RouteHelper.pop(context, const Home())),
        centerTitle: true,
        title: const Text(AppConstant.sendSmsText, style: TextStyle(color: mainWhite)),
        backgroundColor: mainColorGreen700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: dynamicHeight(0.14),
            ),
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
                  if (phone.number.length >= countryS.minLength && phone.number.length <= countryS.maxLength) {
                    numcheckS = true;
                    selectProvider.numtrueS = numcheckS;
                  } else {
                    numcheckS = false;
                    selectProvider.numtrueS = numcheckS;
                  }
                  selectProvider.addnum = phone.completeNumber;
                },
                onCountryChanged: (country) {},
                controller: selectProvider.SenderPhone),
            SizedBox(
              height: dynamicHeight(0.04),
            ),
            CustomTextField(controller: selectProvider.SenderName, hintText: AppConstant.sendSmsNameHintText, keyboardType: TextInputType.name, maxLenght: 50),
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
                    selectProvider.addnew(context);
                    selectProvider.resetsender(1);
                  },
                  child: selectProvider.isLoading
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
            SizedBox(
              height: dynamicHeight(0.14),
            ),
          ]),
        ),
      ),
    );
  }
}
