import 'package:flutter/material.dart';

class RouteHelper {
  static push(BuildContext context, Widget view) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => view));
  }

  static pop(BuildContext context, Widget view) {
    Navigator.pop(context, MaterialPageRoute(builder: (context) => view));
  }
}
