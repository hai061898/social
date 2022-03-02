import 'dart:convert';

import 'package:social/helpers/helpers.dart';
import 'package:social/models/response_login.dart';
import 'package:http/http.dart' as http;
import 'package:social/services/url_api.dart';

class AuthRepositories {
  Future<ResponseLogin> login(String email, String password) async {
    final resp = await http.post(Uri.parse('${UA.urlApi}/auth-login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseLogin> renewLogin() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${UA.urlApi}/auth/renew-login'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }
}

final authRepositories = AuthRepositories();
