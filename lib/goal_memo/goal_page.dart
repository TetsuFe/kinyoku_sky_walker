import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/goal_memo/goal_edit_page.dart';
import 'package:kinyoku_continue/goal_memo/goal_memo_form_controller.dart';

class GoalMemoPage extends StatelessWidget {
  const GoalMemoPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(children: [
          Consumer(
            (context, read) => StreamBuilder<String>(
                initialData:
                    read(goalMemoFormControllerProvider).storedTextStream.value,
                stream: read(goalMemoFormControllerProvider).storedTextStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: snapshot.data != ''
                        ? Text(
                            snapshot.data,
                            style: const TextStyle(fontSize: 32),
                          )
                        : const Text(
                            '禁欲の先にある目標を、設定してみましょう。編集ボタンで目標を設定できます。',
                            style: TextStyle(fontSize: 20),
                          ),
                  );
                }),
          ),
          FlatButton(
              color: Theme.of(context).primaryColor,
              child: const Text(
                '編集',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    settings: const RouteSettings(name: '/goalEdit'),
                    builder: (BuildContext context) => GoalMemoEditPage()));
              }),
        ]),
      ),
    );
  }
}
