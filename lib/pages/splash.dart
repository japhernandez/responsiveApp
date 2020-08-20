import 'package:responsiveApp/api/auth.dart';
import 'package:responsiveApp/api/profile.dart';
import 'package:responsiveApp/models/user.dart';
import 'package:responsiveApp/providers/me.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _auth = Auth();
  final _profile = Profile();
  Me _me;

  @override
  void initState() {
    super.initState();
    this.check();
  }

  check() async {
    final token = await _auth.getAccessToken();

    if (token != null) {
      final result = await _profile.getUserInfo(context, token);
      final user = User.fromJson(result);
      _me.data = user;

      Navigator.pushReplacementNamed(context, 'home');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    _me = Me.of(context);
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(radius: 15),
      ),
    );
  }
}
