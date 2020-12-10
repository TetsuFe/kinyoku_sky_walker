import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'calendar_memo_date_adapter.dart';
import 'memo_repository.dart';

class MemoForm extends StatefulWidget {
  MemoForm({@required this.calendarDate, @required this.onSubmitCompleted});

  final DateTime calendarDate;
  final VoidCallback onSubmitCompleted;
  @override
  _MemoFormState createState() => _MemoFormState();
}

class _MemoFormState extends State<MemoForm> {
  final _memoInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _memoInputController.text = MemoRepository().read(CalendarMemoDateAdapter()
            .transferToMemoDate(widget.calendarDate)) ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text('メモを編集', style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TextFormField(
                  controller: _memoInputController,
                  minLines: 5,
                  maxLines: 15,
                  validator: (value) {
                    return null;
                  },
                  textAlign: TextAlign.start,
                ),
              ),
              FlatButton(
                child: const Text(
                  '保存',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                shape: const StadiumBorder(),
                onPressed: submit,
              )
            ],
          ))
    ]);
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      // goalNotifierProvider.read(context).update(inputNumber());
      final memoDate =
          CalendarMemoDateAdapter().transferToMemoDate(widget.calendarDate);
      MemoRepository().add(memoDate, _memoInputController.text);
      Navigator.of(context).pop();
      widget.onSubmitCompleted();
    }
  }

  @override
  void dispose() {
    _memoInputController.dispose();
    super.dispose();
  }
}
