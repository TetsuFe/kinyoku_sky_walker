import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatLinkButton extends StatelessWidget {
  const ChatLinkButton();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            _openUrl();
          },
          icon: const Icon(
            Icons.chat,
          ),
        ),
      ),
      const Text(
        'チャット',
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }

  void _openUrl() async {
    const url = 'https://line.me/ti/g2/hcN5drDd6NZDcQnW_M4FVw';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
