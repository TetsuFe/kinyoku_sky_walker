import 'package:flutter/material.dart';

class OtherDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'リセット回数分布',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '禁欲継続日数の中央値',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '5日',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
