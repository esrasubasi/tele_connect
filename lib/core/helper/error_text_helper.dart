import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/color_constant.dart';

class ErrorText {
  static errorMessage(BuildContext context, String errortext) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(color: mainRed, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(children: [
            const Expanded(
              flex: 2,
              child: Icon(
                Icons.error,
                color: mainWhite,
                size: 50,
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 7,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  errortext,
                  style: const TextStyle(fontSize: 18, color: mainWhite, fontWeight: FontWeight.bold),
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
