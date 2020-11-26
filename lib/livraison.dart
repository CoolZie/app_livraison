import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'class/apihttp.dart';

class livraison extends StatefulWidget {
  livraison(
      {this.text = '',
      this.livr,
      this.data = '',
      this.index = 1,
      this.onDelete});
  String text;
  int index;
  var livr;
  String data;
  Function(int) onDelete;

  @override
  _livraisonState createState() => _livraisonState();
}

class _livraisonState extends State<livraison> {
  String value = 'flutter';
  Map<String, dynamic> data;

  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'Cocody', title: 'Cocody'),
    S2Choice<String>(value: 'Koumassi', title: 'Koumassi'),
    S2Choice<String>(value: 'Adjame', title: 'Adjame'),
  ];

  List<S2Choice<dynamic>> communes = [];
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

  final _livForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 12,
          child: Form(
              key: _livForm,
              child: Column(children: <Widget>[
                SizedBox(height: 10),
                Text(
                  "${widget.text} ${widget.index + 1} ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SmartSelect<dynamic>.single(
                    title: 'Commune du destinataire',
                    placeholder: "Choisissez",
                    value: widget.livr.Commune(),
                    choiceItems: communes,
                    onChange: (state) {
                      widget.livr.setCommune(state.value);
                    }),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.livr.Quartier(),
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    widget.livr.setQuartier(text);
                  },
                  decoration: const InputDecoration(
                      hintText: "Quartier du destinataire",
                      contentPadding: EdgeInsets.only(left: 10, bottom: 1.0)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.livr.Nom(),
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    widget.livr.setNom(text);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Nom et prenoms du destinataire',
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
                  initialValue: widget.livr.Contact(),
                  keyboardType: TextInputType.phone,
                  onChanged: (text) {
                    widget.livr.setContact(text);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Numero du destinataire',
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
                  initialValue: widget.livr.Nature(),
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    widget.livr.setNature(text);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Nature du colis',
                      contentPadding: EdgeInsets.only(left: 10, bottom: 1.0)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.livr.Montant(),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    widget.livr.setMontant(text);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Montant du colis',
                      contentPadding: EdgeInsets.only(left: 10, bottom: 1.0)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ])),
        ),
        Container(
          color: Colors.transparent,
          child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  widget.onDelete(widget.index);
                },
              )),
        ),
      ],
    );
  }
}
