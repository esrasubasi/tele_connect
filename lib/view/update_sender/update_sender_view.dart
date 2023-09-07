import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/components/custom_textfield.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/general/general_view.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import '../../core/helper/dynamic_helper.dart';
import 'package:tele_connect/core/model/sender_model.dart';
import 'package:tele_connect/view/update_sender/update_sender_view_model.dart';

Senders oldS = Senders(SenderName: "SenderName", SenderNumber: "SenderNumber", SenderCountryCode: "SenderCountryCode");

class SendUpdateApp extends StatefulWidget {
  const SendUpdateApp({super.key});

  @override
  State<SendUpdateApp> createState() => _SendUpdateAppState();
}

class _SendUpdateAppState extends BaseState<SendUpdateApp> {
  FocusNode focusNode = FocusNode();
  int count = 1;
  @override
  Widget build(BuildContext context) {
    final upSelectProvider = Provider.of<UpdateSenderViewModel>(context);
    upSelectProvider.callS(count);
    count = 2;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: mainWhite),
            onPressed: () {
              upSelectProvider.callS(1);
              RouteHelper.pop(context, const Home());
            }),
        centerTitle: true,
        title: const Text("Mesaj Alınacak Kişi Güncelleme",
            style: TextStyle(
              color: mainWhite,
            )),
        backgroundColor: mainColorGreen700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: dynamicHeight(0.14),
            ),
            IntlPhoneField(
                initialValue: oldS.SenderCountryCode,
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
                  upSelectProvider.addnum = phone.completeNumber;
                },
                onCountryChanged: (country) {},
                controller: upSelectProvider.SenderPhoneU),
            SizedBox(
              height: dynamicHeight(0.04),
            ),
            CustomTextField(controller: upSelectProvider.SenderNameU, hintText: AppConstant.sendSmsNameHintText, keyboardType: TextInputType.name, maxLenght: 50),
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
                    upSelectProvider.updatesender(context);
                    upSelectProvider.callS(1);
                  },
                  child: upSelectProvider.isLoading
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
