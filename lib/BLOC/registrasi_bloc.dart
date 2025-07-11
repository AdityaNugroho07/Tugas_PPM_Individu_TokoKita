import 'dart:convert';

import 'package:tokokita/HELPERS/api.dart';
import 'package:tokokita/HELPERS/api_url.dart';
import 'package:tokokita/MODEL/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
    {String? nama, String? email, String? password}) async {
      String apiUrl = ApiUrl.registrasi;

      var body = {"nama": nama, "email": email, "password": password};

      var response = await Api().post(apiUrl, body);
      var jsonObj = json.decode(response.body);
      return Registrasi.fromJson(jsonObj);
    }
}