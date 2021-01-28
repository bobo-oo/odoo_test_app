import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final Function onChanged;
  final TextInputType type;
  final String defaultValue;

  MyTextFormField({
    this.defaultValue,
    this.hintText,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.isPassword = false,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        initialValue: defaultValue,
        onChanged: onChanged,
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: type,
      ),
    );
  }
}