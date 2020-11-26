import 'package:flutter/material.dart';

class Structure extends StatefulWidget {
  Structure({Key key}) : super(key: key);

  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Scaffold(
            appBar: AppBar(title: Text("Trouver une structure")),
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                    child: Text(
                      "Selectionnez la commune",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20.0,
                          spreadRadius: 0.5,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 44.0),
                    margin: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                    child: DropdownButton(
                      isExpanded: true,
                      items: ["1", "2", "3", "4"].map(
                        (val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      value: null,
                      onChanged: (value) {
                        print(value);
                        /* setState(() {
                          _currentSelectedItem = value;
                        }); */
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20.0,
                              spreadRadius: 0.5,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                        child: Card(
                            child: Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Image.asset(
                                  'assets/images/enterprise.png',
                                  width: 100,
                                  height: 100,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.7 -
                                    20,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: new EdgeInsets.only(right: 13.0),
                                      child: Row(children: [
                                        Text("posc",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "posc gjhjhghg gjhghghjgj ghgjhghg gjghgjhg jghg",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.left,
                                      // softWrap: true,
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "Nom : ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                "Exceptionnel Courses et Livraisons",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black)),
                                      ]),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: "Contact: ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: "+22577176121",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black)),
                                      ]),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: "Contact: ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: "+22577176121",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black)),
                                      ]),
                                    ),
                                  ],
                                ))
                          ],
                        )),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
