import 'package:flutter/material.dart';

class ShowDialogWidget {
    static void showErrorDialog({
        required BuildContext context,
        required String title,
        required String message,
        List<Widget>? actions,
    }) {
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: Text(title),
                    content: Text(message),
                    actions: actions ??
                        <Widget>[
                            TextButton(
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                            ),
                        ],
                );
            },
        );
    }
}
