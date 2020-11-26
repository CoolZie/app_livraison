import 'package:flutter/material.dart';
import './drawer.dart';
import 'package:loading_overlay/loading_overlay.dart';
import './class//apihttp.dart';
import './class/authJwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String token;
  @override
  void initState() {
    // super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("livToken");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: MyDrawer(),
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _drawerKey.currentState.openDrawer(),
            ), // open drawer,
            title: Text("Acceuil")),
        body: LoadingOverlay(
          child: Column(
            children: [
              Image.asset('assets/images/h_image.jpg'),
              Row(children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 5,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/livraison');
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/box.png',
                              width: 60,
                              height: 60,
                            ),
                            Text(
                              'Faire une livraison',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 5,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/suivi');
                      },
                      child: Card(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/destination.png',
                            width: 60,
                            height: 60,
                          ),
                          Text(
                            'Suivre une livraison',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      )),
                    )),
              ]),
              Row(children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 5,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/findlivreur');
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/scooter.png',
                              width: 60,
                              height: 60,
                            ),
                            Text(
                              'Trouver un livreur',
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 5,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/aboutus');
                      },
                      child: Card(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/info.png',
                            width: 60,
                            height: 60,
                          ),
                          Text(
                            'A Propos de nous',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      )),
                    )),
              ])
            ],
          ),
          isLoading: false,
          opacity: 0.5,
          progressIndicator: Text(ApiHttp.test()),
        ));
  }
}
