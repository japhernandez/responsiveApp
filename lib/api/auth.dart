import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart' show required;
import 'package:flutter/services.dart';
import 'package:responsiveApp/utils/dialog.dart';
import 'package:responsiveApp/utils/session.dart';
import '../config.dart';

class Auth {
  final _session = Session();

  // ignore: missing_return
  Future<bool> register(BuildContext context,
      {@required String username,
      @required String email,
      @required String password}) async {
    try {
      final url = '${Config.apiHost}/register';
      final data = {'username': username, 'email': email, 'password': password};

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      final parsed = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = parsed['token'] as String;
        final expiresIn = parsed['expiresIn'] as int;
        await _registerToken(token);
        await _session.set(token, expiresIn);
        return true;
      }
    } on PlatformException catch (e) {
      Dialogs.alert(context, title: e.code, message: e.message);
      print("Error  ${e.code} :${e.message}");
      return false;
    }
  }

  // ignore: missing_return
  Future<bool> login(BuildContext context,
      {@required String email, @required String password}) async {
    try {
      final url = '${Config.apiHost}/login';
      final data = {'email': email, 'password': password};

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      final parsed = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = parsed['token'] as String;
        final expiresIn = parsed['expiresIn'] as int;
        await _registerToken(token);
        await _session.set(token, expiresIn);
        return true;
      }
    } on PlatformException catch (e) {
      Dialogs.alert(context, title: e.code, message: e.message);
      print("Error  ${e.code} :${e.message}");
      return false;
    }
  }

  Future<dynamic> _refreshToken(String expiredToken) async {
    try {
      final url = '${Config.apiHost}/tokens​/refresh';
      final response = await http.post(url, headers: {'token': expiredToken});
      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return parsed;
      }
    } on PlatformException catch (e) {
      print("Error  ${e.code} :${e.message}");
      return null;
    }
  }

  // ignore: missing_return
  Future<String> getAccessToken() async {
    try {
      final result = await _session.get();
      if (result != null) {
        final token = result['token'] as String;
        final expiresIn = result['expiresIn'] as int;
        final createdAt = DateTime.parse(result['createdAt']);
        final currentDate = DateTime.now();

        final diff = currentDate.difference(createdAt).inSeconds;

        if (expiresIn - diff >= 60) {
          return token;
        }

        // Refresh token
        final refreshDataToken = await _refreshToken(token);
        if (refreshDataToken != null) {
          final newToken = refreshDataToken['token'];
          final newExpiresIn = refreshDataToken['expiresIn'];
          await _session.set(newToken, newExpiresIn);
          return newToken;
        }
        return null;
      }
      return null;
    } catch (e) {
      print(e);
    }
  }

  _registerToken(String token) async {
    try {
      final url = '${Config.apiHost}/tokens/register';
      final response = await http.post(url, headers: {'token': token});
      if (response.statusCode == 200) {
        return;
      }
    } on PlatformException catch (e) {
      print("Error  ${e.code} :${e.message}");
    }
  }
}
