import 'package:flutter/material.dart';

class TurorialDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SimpleDialog(
      children: [
        Container(
          width: mediaQuery.size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                '使い方',
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('まずはリセットボタンを押して、直近の禁欲失敗日を入力してください。'),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: mediaQuery.size.height * 1 / 2,
                  child: Image.asset('assets/onboarding_page1.png',
                      fit: BoxFit.contain),
                ),
              ),
              FlatButton(
                child: const Text(
                  '始める',
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
