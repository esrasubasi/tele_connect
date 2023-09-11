import 'package:flutter/material.dart';
import 'package:tele_connect/core/constant/color_constant.dart';

class ErrorText {
  static errorMessage(BuildContext context, String errortext) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: mainRed,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.error,
              color: mainWhite,
              size: 50,
            ),
            SizedBox(
              width: 200,
              child: Text(
                errortext,
                style: const TextStyle(fontSize: 18, color: mainWhite, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 3,
      ),
    );
  }
}
