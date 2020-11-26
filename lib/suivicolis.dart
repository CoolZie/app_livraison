import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'class/apihttp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SuiviPage extends StatefulWidget {
  SuiviPage({Key key}) : super(key: key);

  @override
  _SuiviPageState createState() => _SuiviPageState();
}

class _SuiviPageState extends State<SuiviPage> {
  bool isLoading = false;
  String lib_statut = ' Entrer votre code';
  final codeController = TextEditingController();
  Map<String, dynamic> data;
  void checkStatus(statut, type) {
    if (type == "Récupération") {
      if (statut == 0) {
        setState(() {
          lib_statut = "Récuperation en attente";
        });
      } else if ((statut == 1)) {
        setState(() {
          lib_statut = "Récuperation acceptée";
        });
      } else if ((statut == 2)) {
        setState(() {
          lib_statut = "Récuperation effectuée";
        });
      } else if ((statut == 3)) {
        setState(() {
          lib_statut = "Récuperation réportée";
        });
      } else if ((statut == 4)) {
        setState(() {
          lib_statut = "Récuperation annulée";
        });
      } else if ((statut == 5)) {
        setState(() {
          lib_statut = "Récuperation réfusée";
        });
      }
    } else {
      if (statut == 0) {
        setState(() {
          lib_statut = "Livraison En attente";
        });
      } else if ((statut == 1)) {
        setState(() {
          lib_statut = "Livraison en cours";
        });
      } else if ((statut == 2)) {
        setState(() {
          lib_statut = "Livraison effectuée";
        });
      } else if ((statut == 3)) {
        setState(() {
          lib_statut = "Livraison réportée";
        });
      } else if ((statut == 4)) {
        setState(() {
          lib_statut = "Livraison annulée";
        });
      } else if ((statut == 5)) {
        setState(() {
          lib_statut = "Livraison réfusée";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(title: Text("Suivre une livraison")),
      body: LoadingOverlay(
        child: Center(
            child: Form(
                // key: _formKey,
                child: new Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
              Text(
                "Entrer le code de vos livraisons/recuperation",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                margin: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: codeController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    // labelText: "Entrer votre identifiant",
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
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 40,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    ApiHttp.suivre(codeController.text.toUpperCase())
                        .then((value) => {
                              data = jsonDecode(value.body),
                              if (data['code'] == 1)
                                {
                                  print(data['data']['data']['statut']),
                                  checkStatus(data['data']['data']['statut'],
                                      data['data']["type"]),
                                  Alert(
                                    context: context,
                                    type: AlertType.success,
                                    title: "Felicitations",
                                    desc: "",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Fermer",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () =>
                                            {Navigator.pop(context)},
                                        width: 120,
                                      )
                                    ],
                                  ).show(),
                                }
                              else if (data['code'] == 0)
                                {
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "ERREUR",
                                    desc:
                                        "Nous n'avons pas trouvé de livraison ou de récupération pour ce code",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Reessayer",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show()
                                }
                              else
                                {
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "ERREUR",
                                    desc:
                                        "Votre session a expirée ; Veuillez vous reconnecter",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "Reessayer",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/login'),
                                        width: 120,
                                      )
                                    ],
                                  ).show()
                                }
                            })
                        .catchError((error) => {print(error)});
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Suivre"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  lib_statut,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              )
            ]))),
        isLoading: isLoading,
        opacity: 0.5,
      ),
    ));
  }
}
