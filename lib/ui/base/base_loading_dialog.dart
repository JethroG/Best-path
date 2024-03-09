import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    content: Row(
      children: [
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text('Loading Dialog')),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}