import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/counter/models/elapsed_time_notifier.dart';

class DateCounterWidget extends StatelessWidget {
  const DateCounterWidget();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        (context, read) {
          final elapsedTime =
              read(elapsedTimeNotifierProvider).getElapsedTime();
          return Column(
            children: [
              const Text(
                '禁欲開始から',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Text('${elapsedTime.inDays}',
                  style: const TextStyle(fontSize: 56)),
              const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '日',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${elapsedTime.inHours}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const TextSpan(text: ' 時間  '),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${elapsedTime.inMinutes}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const TextSpan(text: ' 分  '),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${elapsedTime.inSeconds}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const TextSpan(text: ' 秒'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
