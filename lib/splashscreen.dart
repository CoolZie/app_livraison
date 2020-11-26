import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'class/authJwt.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AuthJwt.getToken("livToken").then((value) => {
          if (value == null)
            {
              Navigator.pushNamed(context, '/login'),
            },
          Navigator.pushNamed(context, '/'),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
