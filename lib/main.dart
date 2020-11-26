import 'package:app_livraison/splashscreen.dart';
import 'package:app_livraison/structures.dart';
import 'package:flutter/material.dart';
import './home.dart';
import './faire_livraison.dart';
import './suivicolis.dart';
import './findlivreur.dart';
import './aboutus.dart';
import './meslivraisons.dart';
import './login.dart';
import './register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(App());
}

class App extends StatelessWidget {
  // bool isConnected = false;
  String value;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ma livraison',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: value == null ? '/splascreen' : '/',
        routes: {
          '/': (context) => HomePage(),
          '/livraison': (context) => FaireLivraisonPage(),
          '/suivi': (context) => SuiviPage(),
          '/findlivreur': (context) => findLivreurPage(),
          '/aboutus': (context) => aboutUsPage(),
          '/meslivraisons': (context) => mesLivraisonsPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/splascreen': (context) => SplashScreen(),
          '/structure': (context) => Structure(),
        });
  }
}
