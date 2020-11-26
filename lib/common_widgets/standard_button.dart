import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const StandardButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width - 100,
      height: 50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red)),
      color: Colors.blueAccent,
      child: new Text(text,
          style: new TextStyle(fontSize: 16.0, color: Colors.white)),
      onPressed: onPressed,
    );
  }
}
