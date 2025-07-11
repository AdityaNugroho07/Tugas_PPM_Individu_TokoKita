import 'dart:convert';

import 'package:tokokita/HELPERS/api.dart';
import 'package:tokokita/HELPERS/api_url.dart';
import 'package:tokokita/MODEL/login.dart';

class LoginBloc{
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.Login;
    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}