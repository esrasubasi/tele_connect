import 'package:flutter/material.dart';

import '../../core/helper/route_helper.dart';
import '../../main.dart';
import '../general/general_view.dart';

String savedSender = "";

class selectSend {
  final TextEditingController Sender = TextEditingController();

  selectsendonpress(BuildContext con) {
    savedSender = Sender.text;
    RouteHelper.push(con, SmsReadView());
  }
}
