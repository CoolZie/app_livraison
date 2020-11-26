import 'dart:convert';

import 'package:flutter/material.dart';
import './drawer.dart';
import 'class/apihttp.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ModalLivraison extends StatefulWidget {
  String slug;
  ModalLivraison(this.slug);

  @override
  _ModalLivraisonState createState() => _ModalLivraisonState(slug);
}

class _ModalLivraisonState extends State<ModalLivraison> {
  String slug;
  bool isLoading = true;
  List<dynamic> livraisons;
  List<Widget> livraison = List<Widget>();

  _ModalLivraisonState(this.slug);
  void assign() {
    print(this.slug);
    ApiHttp.list_livraison(this.slug)
        .then((value) => {
              if (jsonDecode(value.body)["code"] == 1)
                {
                  livraisons = List.from(jsonDecode(value.body)["data"]),
                  livraisons.forEach((element) {
                    print(element);
                    print(element["commune"]);
                    print(element["quartier"]);
                    print(element["nom"]);
                    print(element["contact"]);
                    print(element["nature"]);
                    print(element["montant"]);
                    print(element["code"]);
                    print(element["statut"]);
                    setState(() {
                      livraison.add(new Livraison(
                        element["commune"],
                        element["quartier"],
                        element["nom"],
                        element["contact"],
                        element["nature"],
                        element["montant"],
                        element["montant_paye"],
                        element["code"],
                        element["statut"],
                        element["observations"],
                      ));
                    });
                  })
                },
              isLoading = false
            })
        .catchError((error) => print(error));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      assign();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("Les livraisons")),
          body: LoadingOverlay(
            child: Container(
                child: ListView.builder(
              itemCount: livraison == null ? 0 : livraison.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(2.0),
              itemBuilder: (context, index) {
                return livraison[index];
              },
            )),
            isLoading: isLoading,
            opacity: 0.5,
          )),
    );
  }
}

class mesLivraisonsPage extends StatefulWidget {
  mesLivraisonsPage({Key key}) : super(key: key);

  @override
  _mesLivraisonsPageState createState() => _mesLivraisonsPageState();
}

class _mesLivraisonsPageState extends State<mesLivraisonsPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Map<String, dynamic> data;
  List<dynamic> recuperation;
  List<Widget> recuperations = List<Widget>();
  bool isLoading = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ApiHttp.list_recuperation()
          .then((value) => {
                data = jsonDecode(value.body),
                if (data["code"] == 1)
                  {
                    setState(() {
                      recuperation = List.from(data["data"]);
                      recuperation.forEach((element) {
                        print(element);
                        recuperations.add(new Recuperation(
                            element['slug'],
                            element['commune'],
                            element['quartier'],
                            element['nom'],
                            element['contact'],
                            element['created_at'],
                            element['observations'],
                            element['code'],
                            element['statut'],
                            element['slug_structure'],
                            element['slug_livreur']));
                      });
                      isLoading = false;
                    }),
                  }
              })
          .catchError((error) => {print("error"), print(error)});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            key: _drawerKey,
            drawer: MyDrawer(),
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => _drawerKey.currentState.openDrawer(),
                ), // open drawer,
                title: Text("Mes récupération/Mes livraisons")),
            body: LoadingOverlay(
              child: Container(
                child: ListView.builder(
                    itemCount: recuperations == null ? 0 : recuperations.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(2.0),
                    itemBuilder: (context, index) {
                      return recuperations[index];
                    }),
              ),
              isLoading: isLoading,
              opacity: 0.5,
            )));
  }
}

class Recuperation extends StatefulWidget {
  String commune;
  String slug;
  String quartier;
  String nom;
  String contact;
  String date;
  String observations;
  String code;
  int statut;
  String structure;
  String livreur;
  Recuperation(
      this.slug,
      this.commune,
      this.quartier,
      this.nom,
      this.contact,
      this.date,
      this.observations,
      this.code,
      this.statut,
      this.structure,
      this.livreur);

  @override
  _RecuperationState createState() => _RecuperationState();
}

class _RecuperationState extends State<Recuperation> {
  List<dynamic> livraison;

  List<Widget> livraisons_ = List<Widget>();
  var lib_statut;
  void checkStatus() {
    if (this.widget.statut == 0) {
      setState(() {
        lib_statut = "Récuperation en attente";
      });
    } else if ((this.widget.statut == 1)) {
      setState(() {
        lib_statut = "Récuperation acceptée";
      });
    } else if ((this.widget.statut == 2)) {
      setState(() {
        lib_statut = "Récuperation effectuée";
      });
    } else if ((this.widget.statut == 3)) {
      setState(() {
        lib_statut = "Récuperation réportée";
      });
    } else if ((this.widget.statut == 4)) {
      setState(() {
        lib_statut = "Récuperation annulée";
      });
    } else if ((this.widget.statut == 5)) {
      setState(() {
        lib_statut = "Récuperation réfusée";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    void _openAddEntryDialog(slug) {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return ModalLivraison(slug);
          },
          fullscreenDialog: true));
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: new GestureDetector(
                      onTap: () {
                        _openAddEntryDialog(widget.slug);

                        // ModalLivraison
                      },
                      child: Card(
                          child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(Icons.ac_unit_outlined),
                              Container(
                                width: MediaQuery.of(context).size.width - 105,
                                child: Text(
                                  "Recuperation a ${widget.commune} ,${widget.quartier} ",
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              Icon(Icons.ac_unit_outlined),
                              Container(
                                width: MediaQuery.of(context).size.width - 105,
                                child: Text(
                                  " ${widget.nom} joignable au ${widget.contact}",
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              Icon(Icons.ac_unit_outlined),
                              Container(
                                width: MediaQuery.of(context).size.width - 105,
                                child: Text(
                                  "Date : ${widget.date}",
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ]),
                            SizedBox(height: 10),
                            Text("Code de suivi : ${widget.code}",
                                style: TextStyle(fontSize: 17)),
                            Text(
                              "Observations : ${widget.observations != null ? widget.observations : ""}",
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "$lib_statut",
                                style: TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ))),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class Livraison extends StatefulWidget {
  String commune;
  String quartier;
  String nom;
  String contact;
  String nature;
  String observations;
  int montant;
  int montant_paye;
  String code;
  int statut;

  Livraison(
      this.commune,
      this.quartier,
      this.nom,
      this.contact,
      this.nature,
      this.montant,
      this.montant_paye,
      this.code,
      this.statut,
      this.observations);

  @override
  _LivraisonState createState() => _LivraisonState();
}

class _LivraisonState extends State<Livraison> {
  String lib_statut;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();
  }

  void checkStatus() {
    if (this.widget.statut == 0) {
      setState(() {
        lib_statut = "En attente";
      });
    } else if ((this.widget.statut == 1)) {
      setState(() {
        lib_statut = "Livraison en cours";
      });
    } else if ((this.widget.statut == 2)) {
      setState(() {
        lib_statut = "Livraison effectuée";
      });
    } else if ((this.widget.statut == 3)) {
      setState(() {
        lib_statut = "Livraison réportée";
      });
    } else if ((this.widget.statut == 4)) {
      setState(() {
        lib_statut = "Livraison annulée";
      });
    } else if ((this.widget.statut == 5)) {
      setState(() {
        lib_statut = "Livraison réfusée";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(1),
          child: Column(children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: new GestureDetector(
                        onTap: () {},
                        child: Card(
                            child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(Icons.ac_unit_outlined),
                                Container(
                                  child: Text(
                                    "Livraison à ${widget.commune} , ${widget.quartier} ",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                )
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                Icon(Icons.ac_unit_outlined),
                                Container(
                                  child: Text(
                                    "A livrer : ${this.widget.nom} , ${this.widget.contact}",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                )
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                Icon(Icons.ac_unit_outlined),
                                Container(
                                  child: Text(
                                    "Nature : ${this.widget.nature}",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                )
                              ]),
                              SizedBox(height: 10),
                              Text(
                                "Montant du colis : ${this.widget.montant} Fcfa",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Montant payé : ${this.widget.montant_paye != null ? this.widget.montant_paye : 0} Fcfa",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Code de suivi : ${this.widget.code}",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text("$lib_statut",
                                    style: TextStyle(fontSize: 17)),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "Observations : ${this.widget.observations != null ? this.widget.observations : "RAS POUR LE MOMENT"}",
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        ))),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
