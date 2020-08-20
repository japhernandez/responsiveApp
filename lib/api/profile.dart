import 'dart:convert';

import 'package:responsiveApp/config.dart';
import 'package:responsiveApp/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Profile {
  Future<dynamic> getUserInfo(BuildContext context, String token) async {
    try {
      final url = "${Config.apiHost}/user-info";
      final response = await http.get(url, headers: {'token': token});
      final parser = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return parser;
      }
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      Dialogs.alert(context, title: e.code, message: e.message);
      return null;
    }
  }
}
