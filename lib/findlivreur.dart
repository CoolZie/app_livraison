import 'package:flutter/material.dart';

class findLivreurPage extends StatefulWidget {
  findLivreurPage({Key key}) : super(key: key);

  @override
  _findLivreurPageState createState() => _findLivreurPageState();
}

class _findLivreurPageState extends State<findLivreurPage> {
  String dropdownValue = "One";

  var _currentSelectedItem = "1";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("Trouver un livreur")),
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Selectionnez la commune",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    value: _currentSelectedItem,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _currentSelectedItem = value;
                      });
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
                              width: MediaQuery.of(context).size.width / 4,
                              child: Image.asset(
                                'assets/images/student.png',
                                width: 100,
                                height: 100,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              width: (MediaQuery.of(context).size.width) -
                                  (MediaQuery.of(context).size.width / 4) -
                                  50,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Nom : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          /* fontWeight: FontWeight.bold */
                                        ),
                                      ),
                                      Text("Coulibaly",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Prenoms : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          /* fontWeight: FontWeight.bold */
                                        ),
                                      ),
                                      Text("Zie Sidiki",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Contact : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text("+225 77176121",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Commune : ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          /* fontWeight: FontWeight.bold */
                                        ),
                                      ),
                                      Text("Yopougon",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Statut : ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          /* fontWeight: FontWeight.bold */
                                        ),
                                      ),
                                      Text("Agrée",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
                                    ],
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
    );
  }
}
