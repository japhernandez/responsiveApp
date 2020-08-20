import 'package:responsiveApp/providers/me.dart';
import 'package:responsiveApp/utils/dialog.dart';
import 'package:responsiveApp/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Me _me;

  @override
  void initState() {
    super.initState();
  }

  _onExit() {
    Dialogs.confirm(context, title: "COFIRM", message: "Are you sure?",
        onCancel: () {
      Navigator.pop(context);
    }, onConfirm: () async {
      Navigator.pop(context);
      Session session = Session();
      await session.clear();
      Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    _me = Me.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (String value) {
                if (value == "exit") {
                  _onExit();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "share",
                  child: Text("Share App"),
                ),
                PopupMenuItem(
                  value: "exit",
                  child: Text("Exit App"),
                )
              ],
            )
          ],
          elevation: 0,
        ),
        body: Center(
          child: Text(_me.data.toJson().toString()),
        ));
  }
}
