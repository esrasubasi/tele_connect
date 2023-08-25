// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tele_connect/core/components/screen_field.dart';
import 'package:tele_connect/core/constant/color_constant.dart';

errorMessage(BuildContext context, String errortext) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      padding: EdgeInsets.all(8.0),
      height: 80,
      decoration: BoxDecoration(color: ColorConstant.MAIN_COLOR_RED, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(children: [
        Icon(
          Icons.error,
          color: ColorConstant.MAIN_COLOR,
          size: 50,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 15,
            ),
            Text(
              errortext,
              style: TextStyle(fontSize: 18, color: ColorConstant.MAIN_COLOR, fontWeight: FontWeight.bold),
            )
          ]),
        )
      ]),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: ColorConstant.MAIN_COLOR.withOpacity(1),
    elevation: 3,
  ));
}
