import 'package:flutter/material.dart';

class aboutUsPage extends StatefulWidget {
  aboutUsPage({Key key}) : super(key: key);

  @override
  _aboutUsPageState createState() => _aboutUsPageState();
}

class _aboutUsPageState extends State<aboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("A Propos de nous")), body: Container()),
    );
  }
}
