// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/color_constant.dart';

class ErrorText {
  static errorMessage(BuildContext context, String errortext) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: mainRed, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Icon(
                Icons.error,
                color: mainWhite,
                size: 50,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 7,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  errortext,
                  style: TextStyle(fontSize: 18, color: mainWhite, fontWeight: FontWeight.bold),
                )
              ]),
            )
          ]),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: mainWhite.withOpacity(0),
      elevation: 3,
    ));
  }
}
