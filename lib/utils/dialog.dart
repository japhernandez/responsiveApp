import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dialogs {
  static void alert(BuildContext context,
      {title = '', message = '', VoidCallback onOk}) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  static void confirm(BuildContext context,
      {String title = '',
      String message: '',
      VoidCallback onCancel,
      VoidCallback onConfirm}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  onPressed: onCancel,
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.redAccent),
                  )),
              CupertinoDialogAction(onPressed: onConfirm, child: Text("OK"))
            ],
          );
        });
  }
}
