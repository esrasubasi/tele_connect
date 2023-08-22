import 'package:flutter/material.dart';

Widget CustomTextField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? hintText,
}) {
  return TextField(
    controller: controller,
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
