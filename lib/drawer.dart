import 'package:flutter/material.dart';
import 'class/authJwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool islogger = false;
  isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString("livToken") ?? null;
    setState(() {
      if (value != null) {
        islogger = true;
      } else {
        islogger = false;
      }
    });
  }

  @override
  void initState() {
    isLogged();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Acceuil'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Mes livraisons'),
            onTap: () {
              Navigator.pushNamed(context, '/meslivraisons');
            },
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Mes Paiements'),
            onTap: () {
              Navigator.pushNamed(context, '/meslivraisons');
            },
          ),
          ListTile(
            leading: Icon(Icons.home_repair_service),
            title: Text('Les Structures'),
            onTap: () {
              Navigator.pushNamed(context, '/structure');
            },
          ),
          islogger
              ? Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_box_rounded),
                      title: Text('Mon compte'),
                      onTap: () {
                        Navigator.pushNamed(context, '/account');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Deconnexion'),
                      onTap: () {
                        Navigator.pushNamed(context, '/account');
                      },
                    )
                  ],
                )
              : ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Connexion'),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                )
        ],
      ),
    );
  }
}
