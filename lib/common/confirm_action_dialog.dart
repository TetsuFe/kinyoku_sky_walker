import 'package:flutter/material.dart';

class ConfirmActionDialog extends StatelessWidget {
  const ConfirmActionDialog({this.title, this.okAction});

  final String title;
  final VoidCallback okAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
            child: const Text('OK'),
            onPressed: () {
              okAction();
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

class ConfirmToResetDialog extends ConfirmActionDialog {
  const ConfirmToResetDialog({String title, VoidCallback okAction})
      : super(title: title, okAction: okAction);
}
