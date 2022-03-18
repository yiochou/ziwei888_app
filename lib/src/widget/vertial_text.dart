import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  final String? text;
  late Color color;

  VerticalText({this.text, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return Container();
    }
    return Wrap(
      runSpacing: 30,
      direction: Axis.vertical,
      alignment: WrapAlignment.center,
      children: text!
          .split("")
          .map((string) => Text(
                string,
                style: TextStyle(color: color),
              ))
          .toList(),
    );
  }
}
