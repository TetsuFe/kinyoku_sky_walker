import 'package:flutter/material.dart';
import 'package:kinyoku_continue/counter/counter_reset_usecase.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:meta/meta.dart';

class SharePromptDialog extends StatelessWidget {
  const SharePromptDialog(
      {@required this.elapsedTimeAtReset, @required this.size});

  final ElapsedTime elapsedTimeAtReset;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '今回の禁欲継続時間をシェアしますか？',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        '「シェアする」を押すと、シェア対象(Twitter・LINE等)を選ぶための確認ダイアログが開きます。',
        style: TextStyle(fontSize: 16),
      ),
      actions: <Widget>[
        FlatButton(
            child: const Text(
              'シェアする',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () async {
              await CounterResetUseCase()
                  .shareElapsedTimeAtReset(elapsedTimeAtReset, size);
              Navigator.of(context).pop();
            }),
        FlatButton(
          child: const Text('しない'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
