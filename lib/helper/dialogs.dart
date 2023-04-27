import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool?> showAlertDialog({
    required BuildContext context,
    required String title,
    required String contentDescription,
    required String noButtonTitle,
    required String yesButtonTile,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        icon: const Icon(
          Icons.warning_amber,
          size: 32.0,
        ),
        title: Text(title),
        content: Text(contentDescription),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(noButtonTitle),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(yesButtonTile),
          )
        ],
      ),
    );
  }
}
