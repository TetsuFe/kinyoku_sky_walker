import 'package:flutter/material.dart';
import 'package:kinyoku_continue/help/help_page.dart';

class HelpButton extends StatelessWidget {
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
            Navigator.of(context).push(MaterialPageRoute(
                settings: const RouteSettings(name: '/help'),
                builder: (BuildContext context) => HelpPage()));
          },
          icon: const Icon(
            Icons.help_outline,
          ),
        ),
      ),
      const Text(
        ' 使い方 ',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
