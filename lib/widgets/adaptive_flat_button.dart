import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  AdaptiveFlatButton({this.text, this.handler});

  final String text;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      //Ктопка вызова календаря
      textColor: Theme.of(context).primaryColor, //стиль по умолчанию
      onPressed: handler,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
