import 'package:flutter/material.dart';

void showCustomDialog(
    {required BuildContext context,
    void Function()? onPressed,
    String? title,
    String? content,
    String? buttonText}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? 'Error'),
        content: Text(content ?? 'An error occurred while loading the page.'),
        actions: <Widget>[
          TextButton(
            child: Text(buttonText ?? 'OK'),
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
