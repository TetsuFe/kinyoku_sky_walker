import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('アップデートがあります。ストアからアップデートをお願いします。'),
      actions: [
        FlatButton(
            child: const Text('後で'),
            onPressed: () {
              Navigator.pop(context);
            }),
        FlatButton(
            child: const Text('ストアを開く'),
            onPressed: () {
              Navigator.pop(context);
              _launchStore();
            })
      ],
    );
  }

  void _launchStore() async {
    final url = Platform.isIOS
        ? 'https://apps.apple.com/jp/app/id1524444519'
        : 'https://play.google.com/store/apps/details?id=dev.tetsufe.kinyoku_continue';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
