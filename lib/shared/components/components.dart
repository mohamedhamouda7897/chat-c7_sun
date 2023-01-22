import 'package:flutter/material.dart';

showLoading(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 5,
                  ),
                  Text(message)
                ],
              ),
            ),
          ));
}

hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(
    BuildContext context, String message, String posBtn, VoidCallback posAction,
    {String? negBtn, VoidCallback? negAction}) {
  showDialog(
    context: context,
    builder: (context) {
      List<Widget> Action = [
        TextButton(onPressed: posAction, child: Text(posBtn)),
      ];
      if (negBtn != null) {
        Action.add(TextButton(onPressed: negAction, child: Text(negBtn)));
      }
      return AlertDialog(
        title: Text(message),
        actions: Action,
      );
    },
  );
}
