import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final double width;
  final double height;
  final EdgeInsets margin;
  final bool obscureText;

  const InputText(
      {Key key,
      this.labelText,
      this.controller,
      this.width,
      this.height,
      this.margin,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin ?? EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.left,
        obscureText: obscureText ?? false,
        style: TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          labelText: labelText,
          labelStyle: new TextStyle(color: Colors.white),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0)),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
