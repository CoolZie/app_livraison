import 'package:app_livraison/constants/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'authJwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHttp {
  static String test() {
    return "Test";
  }

  static Future<http.Response> login(String email, String password) async {
    var response = await http.post("${ApiConstants.BASE_URL}/login",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    print(response.statusCode);
    print(response.body);
    return response;
  }

  static Future<http.Response> register(
    String nom,
    String prenoms,
    String telephone,
    String email,
    String password,
  ) async {
    return await http.post("http://192.168.1.7:8000/api/register",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "nom": nom,
          "prenoms": prenoms,
          "telephone": telephone,
          "email": email,
          "password": password,
        }));
  }

  static Future<http.Response> save_recuperation(
      String nom,
      int commune,
      String quartier,
      String contact,
      String observations,
      List livraisons) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("livToken") ?? null;
    print("Bearer $token");
    var response =
        await http.post("http://192.168.1.7:8000/api/save_recuperation",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': "Bearer $token"
            },
            body: jsonEncode({
              "nom": nom,
              "commune": commune,
              "quartier": quartier,
              "contact": contact,
              "observations": observations,
              "livraisons": jsonEncode(livraisons)
            }));
    print(response.statusCode);
    print(response.body);
    return response;
  }

  static Future<http.Response> list_recuperation() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("livToken") ?? null;
    return await http.get("http://192.168.1.7:8000/api/list_recuperation",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
  }

  static Future<http.Response> list_livraison(String slugRecuperation) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("livToken") ?? null;
    return await http.get(
        "http://192.168.1.7:8000/api/list_livraison?slug_recuperation=$slugRecuperation",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
  }

  static Future<http.Response> suivre(String code) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("livToken") ?? null;
    return await http.get("http://192.168.1.7:8000/api/suivre?code=$code",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
  }

  static Future<http.Response> communes() async {
    return await http
        .get("http://192.168.1.7:8000/api/communes", headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }
}
