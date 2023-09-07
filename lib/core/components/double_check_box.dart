import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class DoubleCheckboxListTile extends StatelessWidget {
  final bool value1;
  final bool value2;
  final Function(bool?) onChanged1;
  final Function(bool?) onChanged2;
  final String title;
  final String subtitle;
  final bool isErrNum;
  final bool isErrM;

  const DoubleCheckboxListTile({
    super.key,
    required this.value1,
    required this.value2,
    required this.onChanged1,
    required this.onChanged2,
    required this.title,
    required this.subtitle,
    required this.isErrNum,
    required this.isErrM,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
        ],
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            Checkbox(
              isError: isErrNum,
              value: value1,
              onChanged: onChanged1,
              activeColor: mainColorGreen700,
              checkColor: mainWhite,
            ),
            Checkbox(
              isError: isErrM,
              value: value2,
              onChanged: onChanged2,
              activeColor: mainColorGreen700,
              checkColor: mainWhite,
            ),
          ],
        ),
      ),
    );
  }
}
