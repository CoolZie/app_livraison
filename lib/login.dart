import 'dart:developer';
import 'package:app_livraison/common_widgets/input_text.dart';
import 'package:app_livraison/common_widgets/standard_button.dart';
import 'package:flutter/material.dart';
import './register.dart';
import 'class/apihttp.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'class/authJwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  TextEditingController emailController;
  TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Map<String, dynamic> user;

  @override
  void initState() {
    emailController = TextEditingController(text: "test@test.com");
    passwordController = TextEditingController(text: "123456");
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/angryimg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: LoadingOverlay(
            child: Center(
              child: Form(
                key: _formKey,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    InputText(
                      controller: emailController,
                      labelText: "Entrez votre login",
                      width: MediaQuery.of(context).size.width - 50,
                    ),
                    InputText(
                      controller: passwordController,
                      labelText: "Entrez votre mot de passe",
                      width: MediaQuery.of(context).size.width - 50,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      obscureText: true,
                    ),
                    StandardButton(
                      text: 'CONNEXION',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          ApiHttp.login(
                                  emailController.text, passwordController.text)
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
                                        ).show(),
                                      }
                                    else
                                      {
                                        AuthJwt.saveToken(
                                            "livToken", user['token']),
                                        Navigator.pushNamed(context, '/'),
                                      }
                                  })
                              .catchError((error) => {
                                    print(error),
                                  });
                        }
                      },
                    ),
                    FlatButton(
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()))
                            },
                        child:
                            Text("Vous n'avez pas de compte , inscrivez vous"))
                  ],
                ),
              ),
            ),
            isLoading: isLoading,
            opacity: 0.5,
          ))
    ]);
  }
}
