import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time_notifier.dart';
import 'package:kinyoku_continue/share/global_keys.dart';
import 'package:kinyoku_continue/share/share.dart';

class PlatformShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Consumer((context, read) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Consumer((context, read) {
            final elapsedTime =
                read(elapsedTimeNotifierProvider).getElapsedTime();
            return IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ShareOptionDialog(elapsedTime: elapsedTime),
                );
              },
              icon: const Icon(
                Icons.share,
              ),
            );
          }),
        );
      }),
      const Text(
        ' シェア ',
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }
}

class ShareOptionDialog extends StatelessWidget {
  const ShareOptionDialog({@required this.elapsedTime});

  final ElapsedTime elapsedTime;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '画像あり・なしを選んでください。',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text(
            'あり',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            ShareProvider()
                .openPlatformShareDialogForCurrentElapsedTime(elapsedTime, key);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
            child: const Text('なし'),
            onPressed: () {
              ShareProvider().openPlatformShareDialogForElapsedTimeWithoutImage(
                  elapsedTime);
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
