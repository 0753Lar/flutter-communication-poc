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
        title: Text(title ?? 'Dialog'),
        content: Text(content ?? ''),
        actions: <Widget>[
          TextButton(
            child: Text(buttonText ?? 'OK'),
            onPressed: () {
              Navigator.of(context).pop();
              if (onPressed != null) {
                onPressed();
              }
            },
          ),
        ],
      );
    },
  );
}
