import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:smart_select/smart_select.dart';
import 'dart:developer';
import 'class/recuperation.dart';
import 'class/livraison.dart';
// import './recaplivraison.dart';
import './livraison.dart';
import 'class/apihttp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FaireLivraisonPage extends StatefulWidget {
  FaireLivraisonPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FaireLivraisonPageState createState() => _FaireLivraisonPageState();
}

class _FaireLivraisonPageState extends State<FaireLivraisonPage> {
  // GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Widget> _livraison = List<Widget>();
  List<Widget> recap_livraison = List<Widget>();
  List<Livraison> livraisons = List<Livraison>();
  // var livraison = new Livraison();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data;

  String value;
  List<S2Choice<dynamic>> communes = [];
  var recuperation = new Recuperation(null, null, null, null, null);

  List<S2Choice<String>> options;
  void lodCommune() {
    ApiHttp.communes().then((value) => {
          data = jsonDecode(value.body),
          if (data["code"] == 1)
            {
              // communes = List.from(data["data"])
              List.from(data["data"]).forEach((element) {
                print(element);
                communes.add(
                  S2Choice<dynamic>(
                      value: element["id"], title: element["libelle"]),
                );
              })
            }
        });
  }

  @override
  void initState() {
    lodCommune();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // key: _drawerKey,
        // drawer: MyDrawer(),
        appBar: AppBar(
            /*  leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _drawerKey.currentState.openDrawer(),
            ), // open drawer, */
            title: Text("Effectuer une livraison")),
        body: Container(
          child: CoolStepper(
            config: CoolStepperConfig(
                backText: "Précedent",
                nextText: "Suivant",
                stepText: "Etape",
                ofText: "sur"),
            onCompleted: () {
              log('finish finish !');
              ApiHttp.save_recuperation(
                      recuperation.Nom(),
                      recuperation.Commune(),
                      recuperation.Quartier(),
                      recuperation.Contact(),
                      recuperation.Observation(),
                      livraisons)
                  .then((value) => {
                        data = jsonDecode(value.body),
                        if (data['code'] == 1)
                          {
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Felicitations",
                              desc:
                                  "Vos livraisons on été enregistré , dans peu un livreur vous contactera",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Fermer",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => {
                                    Navigator.pushNamed(
                                        context, '/meslivraisons')
                                  },
                                  width: 120,
                                )
                              ],
                            ).show()
                          }
                        else if (data['code'] == 0)
                          {
                            Alert(
                              context: context,
                              type: AlertType.error,
                              title: "ERREUR",
                              desc:
                                  "Nous n'avons pas pu emettre vos livraisons",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Reessayer",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/login'),
                                  width: 120,
                                )
                              ],
                            ).show()
                          }
                      })
                  .catchError((error) => {
                        print("${error}"),
                      });
            },
            steps: <CoolStep>[
              CoolStep(
                  title: "Information de récuperation",
                  subtitle:
                      "Donnez nous toutes les informations rélatives à votre récuperation de colis",
                  content: Container(
                    child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          SmartSelect<dynamic>.single(
                              title: 'Commune',
                              placeholder: "Choisissez",
                              value: recuperation.Commune(),
                              choiceItems: communes,
                              onChange: (state) {
                                recuperation.setCommune(state.value);
                              }),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: recuperation.Quartier(),
                            keyboardType: TextInputType.text,
                            onChanged: (text) {
                              recuperation.setQuartier(text);
                            },
                            decoration: const InputDecoration(
                                hintText: 'Entrer le quartier',
                                contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 1.0)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            initialValue: recuperation.Nom(),
                            onChanged: (text) {
                              recuperation.setNom(text);
                            },
                            decoration: const InputDecoration(
                                hintText: 'Entrer votre nom et prenoms',
                                contentPadding: EdgeInsets.only(left: 10)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            initialValue: recuperation.Contact(),
                            onChanged: (text) {
                              recuperation.setContact(text);
                            },
                            decoration: const InputDecoration(
                                hintText: 'Entrer le numero à contacter',
                                contentPadding: EdgeInsets.only(left: 10)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            initialValue: recuperation.Observation(),
                            onChanged: (text) {
                              recuperation.setObservation(text);
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: 8,
                            maxLength: 1000,
                            decoration: const InputDecoration(
                                hintText: 'Observations',
                                contentPadding: EdgeInsets.only(left: 10)),
                            validator: (value) {
                              /* if (value.isEmpty) {
                                return 'Please enter some text';
                              } */
                              return null;
                            },
                          ),
                        ])),
                  ),
                  validation: () {
                    if (!_formKey.currentState.validate()) {
                      return "Fill form correctly";
                    }
                    return null;
                  }),
              CoolStep(
                  title: "Information de(s) livraison(s)",
                  subtitle:
                      "Donnez nous toutes les informations rélatives à vos/votre livraison(s)",
                  content: Container(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                              onPressed: () {
                                var livr = new Livraison();
                                livraisons.add(livr);
                                setState(() {
                                  _livraison.add(livraison(
                                    livr: livr,
                                    text: "livraisons !",
                                    data: 'test',
                                    index: _livraison.length,
                                    onDelete: (int index) {
                                      setState(() {
                                        _livraison.removeAt(index);
                                      });
                                    },
                                  ));
                                });
                              },
                              child: Text("Ajouter une livraison")),
                          RaisedButton(
                              color: Colors.orange,
                              onPressed: () {
                                var livr = new Livraison();
                                livraisons.add(livr);
                                setState(() {
                                  _livraison.removeLast();
                                  recap_livraison.removeLast();
                                  livraisons.removeLast();
                                });
                              },
                              child: Text(
                                "Supprimer une livraison",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                          children: List.generate(_livraison.length, (index) {
                        return _livraison[index];
                      }))
                    ],
                  )),
                  validation: () {
                    /* livraisons.forEach((livraison) {
                      recap_livraison.add(RecapLivraison(livraison));
                      log(livraison.Commune());
                      log(livraison.Quartier());
                      log(livraison.Contact());
                      log(livraison.Nom());
                      log(livraison.Nature());
                      log(livraison.Montant());
                    }); */
                  }),
              /*  CoolStep(
                  title: "Récapitulatif de vos informations",
                  subtitle: "Toutes les informations entrées",
                  content: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Information de recuperation",
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(children: [
                                      Icon(Icons.ac_unit_outlined),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                105,
                                        child: Text(
                                          "Recuperation a ${recuperation.Commune()} ,${recuperation.Quartier()} ",
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ])),
                                Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(children: [
                                      Icon(Icons.ac_unit_outlined),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                105,
                                        child: Text(
                                          "${recuperation.Nom()} , ${recuperation.Contact()}",
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ])),
                                Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                105,
                                        child: Text(
                                          "${recuperation.Observation()}",
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ])),
                              ],
                            ),
                          ),
                        ),
                        Text("Informations des livraisons"),
                        Column(
                          children: recap_livraison,
                        )
                      ],
                    ),
                  ),
                  validation: () {
                    log("last step !");
                  }) */
            ],
          ),
        ));
  }
}
