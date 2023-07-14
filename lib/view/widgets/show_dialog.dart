import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String content,
    String action) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type AlertDialog
      return AlertDialog(
        title: Text(title),
        // const Text("Invalid Details"),
        content: Text(content),
        //const Text(
        // "You have inputed a wrong login detail, kindly try again"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          TextButton(
            child: Text(
              action,
              style: const TextStyle(color: Colors.black),
            ),
            onPressed: () {
                Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
