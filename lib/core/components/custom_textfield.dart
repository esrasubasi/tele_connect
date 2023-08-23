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
    keyboardType: TextInputType.phone,
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
