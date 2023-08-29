// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_connect/core/components/custom_textfield.dart';
import 'package:tele_connect/core/constant/app_constant.dart';
import 'package:tele_connect/core/helper/route_helper.dart';
import 'package:tele_connect/view/general/general_view.dart';
import 'package:tele_connect/core/constant/color_constant.dart';
import '../../core/components/screen_field.dart';
import 'package:tele_connect/view/selectSend/select_send_view_model.dart';

class SendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddSenderViewModel(),
      child: MaterialApp(
        home: SendApp(),
      ),
    );
  }
}

class SendApp extends StatefulWidget {
  @override
  State<SendApp> createState() => _SendAppState();
}

class _SendAppState extends BaseState<SendApp> {
  @override
  Widget build(BuildContext context) {
    final selectProvider = Provider.of<AddSenderViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: ColorConstant.MAIN_BLACK), onPressed: () => RouteHelper.push(context, SmsReadView())),
        centerTitle: true,
        title: Text(AppConstant.SEND_SMS_TEXT, style: TextStyle(color: ColorConstant.MAIN_COLOR)),
        backgroundColor: ColorConstant.MAIN_COLOR_GREEN700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: dynamicHeight(0.14),
            ),
            CustomTextField(controller: selectProvider.SenderPhone, hintText: AppConstant.SEND_SMS_HINT_TEXT, keyboardType: TextInputType.phone, maxLenght: 13),
            SizedBox(
              height: dynamicHeight(0.04),
            ),
            CustomTextField(controller: selectProvider.SenderName, hintText: AppConstant.SEND_SMS_NAME_HINT_TEXT, keyboardType: TextInputType.name, maxLenght: 50),
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
                    selectProvider.addnew(context);
                  },
                  child: selectProvider.isLoading
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
            SizedBox(
              height: dynamicHeight(0.14),
            ),
          ]),
        ),
      ),
    );
  }
}
