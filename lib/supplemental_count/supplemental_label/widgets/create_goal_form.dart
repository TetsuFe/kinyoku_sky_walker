import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/goal_notifier.dart';

class UpdateSupplementalLabelForm extends StatefulWidget {
  @override
  _UpdateSupplementalLabelFormState createState() =>
      _UpdateSupplementalLabelFormState();
}

class _UpdateSupplementalLabelFormState
    extends State<UpdateSupplementalLabelForm> {
  final _labelInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final supplementalLabel =
        supplementalLabelNotifierProvider.read(context).label;
    if (supplementalLabel != null) {
      _labelInputController.text = supplementalLabel.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: TextFormField(
                controller: _labelInputController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return '1文字以上を設定してください。';
                  }
                  return null;
                },
                textAlign: TextAlign.center,
              ),
            ),
            FlatButton(
              child: const Text(
                '決定',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              shape: const StadiumBorder(),
              onPressed: submit,
            )
          ],
        ));
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      supplementalLabelNotifierProvider
          .read(context)
          .update(_labelInputController.text);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _labelInputController.dispose();
    super.dispose();
  }
}
