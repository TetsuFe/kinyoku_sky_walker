import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/admob/banner_ad_height.dart';
import 'package:kinyoku_continue/common/confirm_action_dialog.dart';
import 'package:kinyoku_continue/goal_memo/goal_memo_form_controller.dart';

class GoalMemoEditPage extends StatefulWidget {
  @override
  _GoalMemoEditPageState createState() => _GoalMemoEditPageState();
}

class _GoalMemoEditPageState extends State<GoalMemoEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const BannerADSpacer(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: MemoForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemoForm extends StatefulWidget {
  @override
  _MemoFormState createState() => _MemoFormState();
}

class _MemoFormState extends State<MemoForm> {
  final _key = GlobalKey<FormState>();
  GoalMemoFormController _formController;

  @override
  void initState() {
    super.initState();
    _formController = goalMemoFormControllerProvider.read(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          const Text(
            '目標の編集',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: TextFormField(
              controller: _formController.controller,
              style: const TextStyle(fontSize: 32),
              onSaved: (text) {
                _formController.save();
              },
              maxLines: 15,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => ConfirmActionDialog(
                              okAction: () {
                                Navigator.pop(context);
                              },
                              title: '今回書いた内容を反映せず終了しますか？',
                            ));
                  },
                  child: const Text(
                    '戻る',
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmActionDialog(
                      okAction: () {
                        _key.currentState.save();
                        Navigator.pop(context);
                      },
                      title: '今回書いた内容で上書きしますか？',
                    ),
                  );
                },
                child: const Text(
                  '更新',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
