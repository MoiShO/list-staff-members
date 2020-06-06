import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultInput extends StatelessWidget {
  const DefaultInput({
    Key key,
    this.hintText,
    this.labelText,
    this.controller,
    this.focusNode
  }) : super(key: key);
  
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      decoration: new InputDecoration(
        hintText: hintText,
        labelText: labelText
      ),
      validator: (String  string) {
        /// TODO валидация
        if(string == null || string?.trim() == '' ) {
          return 'Поле обязательно для ввода';
        } return null;
      },
    );
  }
}