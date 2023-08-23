// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

Widget CustomTextField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? hintText,
  int? maxLenght,
}) {
  return TextField(
    controller: controller,
    maxLength: maxLenght,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
      suffixIcon: IconButton(
        onPressed: () {
          controller?.clear();
        },
        icon: Icon(Icons.clear),
      ),
    ),
  );
}
