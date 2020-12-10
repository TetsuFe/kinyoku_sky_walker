import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/goal_notifier.dart';

class CreateGoalForm extends StatefulWidget {
  @override
  _CreateGoalFormState createState() => _CreateGoalFormState();
}

class _CreateGoalFormState extends State<CreateGoalForm> {
  final _numberInputController = TextEditingController();
  int inputNumber() => int.parse(_numberInputController.text);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final currentGoalDays = goalNotifierProvider.read(context).goal.days;
    if (currentGoalDays != null) {
      _numberInputController.text = currentGoalDays.toString();
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _numberInputController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return '数値を設定してください。';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Text('日'),
                ],
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
      goalNotifierProvider.read(context).update(inputNumber());
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _numberInputController.dispose();
    super.dispose();
  }
}
