import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time_sum_notifier.dart';

class ProhibitedMatterTimeSumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              '累計発散時間',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 32),
              child: Consumer((context, read) {
                final prohibitedMatterTimeSum =
                    read(prohibitedMatterTimeSumNotifierProvider)
                        .prohibitedMatterTimeSum;
                if (prohibitedMatterTimeSum == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text(
                    '${prohibitedMatterTimeSum.hours}時間'
                    ' ${prohibitedMatterTimeSum.minutes}分',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
