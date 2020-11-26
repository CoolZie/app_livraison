import 'package:app_livraison/class/livraison.dart';
import 'package:flutter/material.dart';

class RecapLivraison extends StatelessWidget {
  var livraison;
  RecapLivraison(Livraison this.livraison);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(children: [
                  Icon(Icons.ac_unit_outlined),
                  Container(
                    width: MediaQuery.of(context).size.width - 105,
                    child: Text(
                      "Livraison a ${livraison.Commune()} , ${livraison.Quartier()}",
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ])),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(children: [
                  Icon(Icons.ac_unit_outlined),
                  Container(
                    width: MediaQuery.of(context).size.width - 105,
                    child: Text(
                      "${livraison.Nom()} , ${livraison.Contact()}",
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ])),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(children: [
                  Icon(Icons.ac_unit_outlined),
                  Container(
                    width: MediaQuery.of(context).size.width - 105,
                    child: Text(
                      "${livraison.Nature()} , ${livraison.Montant()} Fcfa",
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
