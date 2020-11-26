import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'class/apihttp.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  String nom;
  String prenoms;
  String telephone;
  String email;
  String password;
  String confirm_password;
  final nomController = TextEditingController();
  final prenomsController = TextEditingController();
  final telephoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirm_passwordController = TextEditingController();
  Map<String, dynamic> user;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
          child: Stack(children: <Widget>[
        Image.asset(
          "assets/images/angryimg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        LoadingOverlay(
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 100),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'REGISTER',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 35),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: nomController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Entrer votre nom",
                                labelStyle: new TextStyle(color: Colors.white),
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: prenomsController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Entrer votre prenoms",
                                labelStyle: new TextStyle(color: Colors.white),
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: telephoneController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Entrer votre telephone",
                                labelStyle: new TextStyle(color: Colors.white),
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: emailController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Entrer votre email",
                                labelStyle: new TextStyle(color: Colors.white),
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: passwordController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Entrer votre mot de passe",
                                labelStyle: new TextStyle(color: Colors.white),
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 50,
                            margin: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: confirm_passwordController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                labelText: "Repeter votre mot de passe",
                                labelStyle: new TextStyle(color: Colors.white),
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width - 100,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            color: Colors.blueAccent,
                            child: new Text('INSCRIPTION',
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                ApiHttp.register(
                                        nomController.text,
                                        prenomsController.text,
                                        telephoneController.text,
                                        emailController.text,
                                        passwordController.text)
                                    .then((value) => {
                                          setState(() {
                                            isLoading = false;
                                          }),
                                          user = jsonDecode(value.body),
                                          if (user['code'] == 0)
                                            {
                                              Alert(
                                                context: context,
                                                type: AlertType.error,
                                                title: "ERREUR",
                                                desc:
                                                    "Votre identifiant / Mot de passe incorrect",
                                                buttons: [
                                                  DialogButton(
                                                    child: Text(
                                                      "Fermer",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    width: 120,
                                                  )
                                                ],
                                              ).show()
                                            }
                                          else
                                            {
                                              {
                                                Navigator.pushNamed(
                                                    context, '/login')
                                              },
                                            }
                                        });
                              }
                            },
                          ),
                          FlatButton(
                              onPressed: () =>
                                  {Navigator.pushNamed(context, '/login')},
                              child: Text(
                                  "Vous avez deja un compte , connectez vous"))
                        ]))),
            isLoading: isLoading,
            opacity: 0.5)
      ])),
    );
  }
}
