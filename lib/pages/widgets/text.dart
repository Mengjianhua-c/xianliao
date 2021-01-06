import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String txt = '';

  MyText(String txt) {
    this.txt = txt;
  }

  @override
  Widget build(BuildContext context) {
    return Text(txt==null? '': txt);
  }
}
