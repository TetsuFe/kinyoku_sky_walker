import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/supplemental_count/models/elapsed_time_notifier.dart';

class SupplementalDateCounterWidget extends StatelessWidget {
  const SupplementalDateCounterWidget({@required this.supplementalLabel});

  final String supplementalLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        (context, read) {
          final elapsedTimeNotifier =
              read(supplementalElapsedTimeNotifierProvider);
          return Column(
            children: [
              Text(
                '$supplementalLabelから',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Text('${elapsedTimeNotifier.elapsedTime.inDays}',
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
                          text: '${elapsedTimeNotifier.elapsedTime.inHours}',
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
                          text: '${elapsedTimeNotifier.elapsedTime.inMinutes}',
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
                          text: '${elapsedTimeNotifier.elapsedTime.inSeconds}',
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
